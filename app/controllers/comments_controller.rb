class CommentsController < ApplicationController
  def likes
    # No limit
    Comment.increment_counter(:likes, params[:id])
    render text: :success
  end
end
