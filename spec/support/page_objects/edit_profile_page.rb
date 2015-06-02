require "support/page_objects/page"

class EditProfilePage < Page
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def visit
    sign_in
    page.visit edit_user_registration_path
  end

  def refresh
    page.visit edit_user_registration_path
  end

  def sign_in
    page.visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  def update_account_info(options)
    confirm = options[:confirm] ? options[:confirm] : options[:new_password]

    within "#edit_user" do
      fill_in "user_email", with: options[:email]
      fill_in "user_password", with: options[:new_password]
      fill_in "Password confirmation", with: confirm
      fill_in "Current password", with: options[:password]
      click_button "Update"
    end
  end

  def choose_pic_to_upload(file = "test.jpg")
    attach_file "profile_pic", "#{Rails.root}/spec/support/images/#{file}"
  end

  def click_update_button(id)
    click_button id
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

