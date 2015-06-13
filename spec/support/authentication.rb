def sign_in_with(options)
  visit root_path
  fill_in "Email", with: options[:email]
  fill_in "Password", with: options[:password]
  click_button "Sign In"
end

def sign_in(user)
  sign_in_with(email: user.email, password: user.password)
end

