require "support/page_objects/page"

class SignInPage < Page
  def visit
    page.visit root_path
  end

  def sign_in(options = {})
    fill_in "Email", with: options[:email]
    fill_in "Password", with: options[:password]
    click_button "Sign In"
  end

  def has_email_field?
    has_field? "Email"
  end

  def has_password_field?
    has_field? "Password"
  end

  def has_sign_in_button?
    has_button? "Sign In"
  end

  def sign_in_path
    new_user_session_path
  end
end

