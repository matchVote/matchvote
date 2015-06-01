require "support/page_objects/page"

class ProfilePage < Page
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def visit
    sign_in
    click_link "view_profile_link"
  end

  def sign_in
    page.visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
  
  def refresh
    click_link "view_profile_link"
  end

  def has_edit_profile_link?
    has_link? "Edit Profile"
  end

  def has_edit_privacy_link?
    has_link? "Edit Privacy"
  end

  def has_edit_stances_link?
    has_link? "Edit Stances"
  end

  def click_edit_profile_link
    click_link "Edit Profile"
  end

  def click_edit_privacy_link
    click_link "Edit Privacy"
  end

  def click_edit_stances_link
    click_link "Edit Stances"
  end

  def editing?
    has_content? "Edit your profile and political stances."
  end
  
  def profile_pic_url
    find(".profile_pic")[:src]
  end

  def has_aws_url_for_profile_pic?
    profile_pic_url.match(/s3\.amazonaws\.com\/uploads\/user\/profile_pic/)
  end
end

