class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_resource

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform that action."
      redirect_to(request.referrer || root_url)
    end

    def set_resource
      @resource = if navbar_dropdown_options.include?(params[:controller])
        params[:controller]
      else
        "directory"
      end
    end

    def navbar_dropdown_options
      ["directory", "forum", "news", "elections", "townhall", "stances"]
    end
end
