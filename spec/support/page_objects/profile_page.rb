require "support/page_objects/page"

class ProfilePage < Page
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def visit
    sign_in
    click_link "#view_profile_link"
  end

  def sign_in
    page.visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  def click_profile_link
    find("view_profile_link").click
  end
end

