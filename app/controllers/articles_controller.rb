require "will_paginate/array"
require_dependency "lib/articles/article_collection"

class ArticlesController < ApplicationController
  include ArticleCollection

  COMMENT_LIMIT = 5
  REPLY_LIMIT = 4
  PER_PAGE = 10

  def index
    @comment_limit = COMMENT_LIMIT
    @reply_limit = REPLY_LIMIT
    articles = Article
      .includes(:comments, :bookmarks, :user_article_changes)
      .where(date_published: Time.zone.now.beginning_of_day...Time.zone.now.end_of_day)
      .order(newsworthiness_count: :desc)
    @article_count = articles.count
    @publisher_count = articles.select(:publisher).distinct.count
    @articles = articles
      .map(&ArticlePresenter)
      .paginate(page: params[:page], per_page: PER_PAGE)
    @most_mentioned_reps = Representative
      .most_mentioned(articles)
      .map(&RepresentativePresenter)
  end

  def api_index
    @comment_limit = COMMENT_LIMIT
    @reply_limit = REPLY_LIMIT
    articles = collect_articles(params, current_user)
    publisher_count = articles.pluck(:publisher).uniq.count
    @articles = articles
      .map(&ArticlePresenter)
      .paginate(page: params[:page], per_page: PER_PAGE)
    @most_mentioned_reps = Representative
      .most_mentioned(articles)
      .map(&RepresentativePresenter)
    dates = articles.map(&:date_published)
    stats = {
      selected_dates: ArticlesHelper.format_dates(dates),
      article_count: articles.count,
      publisher_count: publisher_count
    }
    articles_view = filtering_followed_but_not_following? ? 'not_following' : 'api_index'
    render json: {
      articles: view_context.render(articles_view),
      most_mentions: view_context.render('most_mentions'),
      stats: stats
    }
  end

  def show
    @article = ArticlePresenter.new(Article.find(params[:id]))
    @reply_limit = BigDecimal('Infinity')
    Article.increment_counter(:read_count, params[:id])
  end

  def increase_newsworthiness
    change_newsworthiness_count(params[:id], "increment")
    render json: { status: :ok }
  end

  def decrease_newsworthiness
    change_newsworthiness_count(params[:id], "decrement")
    render json: { status: :ok }
  end

  def bookmark
    bookmark = Bookmark.find_by(article_id: params[:id], user_id: current_user.id)
    if bookmark
      bookmark.destroy
      render json: { active: false }
    else
      Bookmark.create(article_id: params[:id], user_id: current_user.id)
      render json: { active: true }
    end
  end

  private

  def article_filters
    params[:filters] || {}
  end

  def change_newsworthiness_count(article_id, type)
    user_article_params = { article_id: article_id, user_id: current_user.id }
    change = UserArticleChange
      .where(user_article_params)
      .where("change_type like 'newsworthiness_%'").first
    if change
      UserArticleChange.transaction do
        update_newsworthiness_count(article_id, type)
        change.destroy
      end
    else
      UserArticleChange.transaction do
        update_newsworthiness_count(article_id, type)
        user_article_params[:change_type] = "newsworthiness_#{type}"
        UserArticleChange.create(user_article_params)
      end
    end
  end

  def update_newsworthiness_count(article_id, type)
    Article.send("#{type}_counter", :newsworthiness_count, article_id)
  end

  def filtering_followed_but_not_following?
    article_filters[:followed] == 'true' && @articles.empty?
  end
end
