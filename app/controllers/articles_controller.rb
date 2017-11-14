require "will_paginate/array"

class ArticlesController < ApplicationController
  COMMENT_LIMIT = 5
  REPLY_LIMIT = 4
  PER_PAGE = 10

  def index
    @comment_limit = COMMENT_LIMIT
    @reply_limit = REPLY_LIMIT
    @articles = Article
      .includes(:comments, :bookmarks)
      .order(date_published: :desc)
      .map(&ArticlePresenter)
      .paginate(page: params[:page], per_page: PER_PAGE)
  end

  def show
    @article = ArticlePresenter.new(Article.find(params[:id]))
  end

  def newsworthiness
    article_id = params[:id]
    change = find_article_change(article_id)
    type = newsworthiness_change_type(change)
    reverse_newsworthiness_vote(change, article_id, type) if type
    if params[:type] != type
      create_newsworthiness_vote(change, article_id, params[:type])
    end
    render json: { previous_type: type }
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

    if params['sort'] == 'comment_count'
      articles = Article
        .joins('LEFT JOIN comments C on C.commentable_id = articles.id')
        .includes(:bookmarks)
        .group('articles.id')
        .order('count(C.id) DESC')
    else
      articles = Article
        .includes(:comments, :bookmarks)
        .order(sort_mapping[params['sort']] => :desc)
    end

    @articles = articles
      .map(&ArticlePresenter)
      .paginate(page: params[:page], per_page: PER_PAGE)
  end

  def increment_read_count
    Article.increment_counter(:read_count, params[:id])
    head :ok
  end

  private

  def sort_mapping
    { 'newest' => 'date_published',
      'newsworthiness' => 'newsworthiness_count' }
  end

  def newsworthiness_change_type(change)
    change.change_type.split(" ").last
  end

  def create_newsworthiness_vote(change, article_id, type)
    UserArticleChange.transaction do
      Article.send("#{type}_counter", :newsworthiness_count, article_id)
      UserArticleChange.create(
        article_id: article_id,
        user_id: current_user.id,
        change_type: "newsworthiness #{type}")
    end
  end

  def reverse_newsworthiness_vote(change, article_id, type)
    opposite_type = UserArticleChange.opposite_newsworthiness_type(type)
    UserArticleChange.transaction do
      Article.send("#{opposite_type}_counter", :newsworthiness_count, article_id)
      change.destroy
    end
  end

  def find_article_change(id)
    change = UserArticleChange.find_by(article_id: id, user_id: current_user.id)
    change ? change : UserArticleChange.new(change_type: '')
  end

  def user_can_change_article?(id)
    not UserArticleChange.exists?(article_id: id, user_id: current_user.id)
  end
end
