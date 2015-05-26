def signup_with(options)
  confirm = options[:confirm] ? options[:confirm] : options[:password]

  fill_in "Username", with: options[:username]
  fill_in "Email", with: options[:email]
  fill_in "Password", with: options[:password]
  fill_in "Confirm Password", with: confirm
  click_button "Create Account"
end

def sign_in_with(options)
  visit root_path
  fill_in "Email", with: options[:email]
  fill_in "Password", with: options[:password]
  click_button "Sign In"
end

def sign_in(user)
  sign_in_with(email: user.email, password: user.password)
end

def update_user(options)
  confirm = options[:confirm] ? options[:confirm] : options[:new_password]

  within "#edit_user" do
    fill_in "user_email", with: options[:email]
    fill_in "user_password", with: options[:new_password]
    fill_in "Password confirmation", with: confirm
    fill_in "Current password", with: options[:password]
    click_button "Update"
  end
end

