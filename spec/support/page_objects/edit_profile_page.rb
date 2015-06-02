require "support/page_objects/page"

class EditProfilePage < Page
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def visit
    sign_in
    page.visit edit_citizen_path(user)
  end

  def refresh
    page.visit edit_citizen_path(user)
  end

  def sign_in
    page.visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  def edit_other_profile(user)
    page.visit edit_citizen_path(user)
  end

  def choose_pic_to_upload(file = "test.jpg")
    attach_file "user_profile_pic", "#{Rails.root}/spec/support/images/#{file}"
  end

  def click_update_profile_pic_button
    within "#profile_pic_upload" do
      click_button "Update"
    end
  end
  
  def profile_pic_url
    find("#profile_pic_preview")[:src]
  end

  def has_aws_url_for_profile_pic?
    profile_pic_url.match(/s3\.amazonaws\.com\/uploads\/user\/profile_pic/)
  end

  def has_default_pic?
    profile_pic_url == "/assets/default.png"
  end
end

