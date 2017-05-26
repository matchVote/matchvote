class ArticleController < ApplicationController
  def update_newsworthiness
    Rails.logger.info "Editing Article: #{params[:id]}"
  end
end
