class PollsController < ApplicationController
  def create
    Poll.create do |poll|
      poll.user = current_user
      poll.article_id = params[:articleId]
      poll.representative_id = params[:repId]
      poll.response = params[:response]
    end
    head 200
  end
end
