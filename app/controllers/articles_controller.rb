class ArticlesController < ApplicationController
  def index
    @articles = Article.all.map { |a| ArticlePresenter.new(a) }
  end

  def newsworthiness
    if user_can_change_article?(params[:id])
      Article.send("#{params[:type]}_counter", :newsworthiness_count, params[:id])
      create_change(params[:id], "newsworthiness #{params[:type]}")
      head :ok
    else
      head :forbidden
    end
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

  def user_can_change_article?(id)
    !UserArticleChange.exists?(article_id: id, user_id: current_user.id)
  end

  def create_change(id, type)
    UserArticleChange.create(
      article_id: id,
      user_id: current_user.id,
      change_type: type)
  end
end
