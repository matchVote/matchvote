require "support/wait_for_ajax"

class Page
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include WaitForAjax

  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  def sign_in
    page.visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  def signout
    find(:xpath, "//a[@href='#{destroy_user_session_path}']").click
  end
end

