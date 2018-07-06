require "will_paginate/array"
require_relative "#{Rails.root}/lib/articles/article_collection"

class ArticlesController < ApplicationController
  
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
  end

  def show
    @article = ArticlePresenter.new(Article.find(params[:id]))
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

  def api_index
    @comment_limit = COMMENT_LIMIT
    @reply_limit = REPLY_LIMIT
    articles = ArticleCollection.collect_articles(params, current_user)
    publisher_count = articles.select(:publisher).distinct.count
    @articles = articles
      .map(&ArticlePresenter)
      .paginate(page: params[:page], per_page: PER_PAGE)
    date = ArticleCollection.normalize_date(article_filters[:date_published])
    stats = {
      current_date: ArticlesHelper.current_date(date),
      article_count: articles.count,
      publisher_count: publisher_count
    }
    partial = filtering_followed_but_not_following? ? 'not_following' : 'api_index'
    render json: { html: view_context.render(partial), stats: stats }
  end

  def increment_read_count
    Article.increment_counter(:read_count, params[:id])
    head :ok
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

  def user_can_change_article?(id)
    not UserArticleChange.exists?(article_id: id, user_id: current_user.id)
  end

  def filtering_followed_but_not_following?
    article_filters[:followed] == 'true' && @articles.empty?
  end
end
