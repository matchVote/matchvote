require "support/page_objects/page"

class EditAccountPage < Page
  def visit
    sign_in
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
end

