class CommentsController < ApplicationController
  def likes
    if user_can_like?(params[:id])
      Comment.increment_counter(:likes, params[:id])
      create_change(params[:id], "like")
      render text: "liked"
    else
      Comment.decrement_counter(:likes, params[:id])
      remove_change(params[:id])
      render text: "unliked"
    end
  end

  private

  def user_can_like?(id)
    not UserCommentChange.exists?(comment_id: id, user_id: current_user.id)
  end

  def create_change(id, type)
    UserCommentChange.create(
      comment_id: id,
      user_id: current_user.id,
      change_type: type)
  end

  def remove_change(id)
    UserCommentChange.where(comment_id: id, user_id: current_user.id).destroy_all
  end
end
