class ArticlesController < ApplicationController
  def newsworthiness
    if user_can_change_article?(params[:id])
      Article.send("#{params[:type]}_counter", :newsworthiness_count, params[:id])
      create_change(params[:id], :newsworthiness)
      render text: "success"
    else
      head :forbidden
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
