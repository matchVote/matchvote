require "support/page_objects/page"

class SignUpPage < Page
  def visit
    page.visit root_path
    click_link "Create Account"
  end

  def use_default_account_info
    fill_in "Username", with: "leroy_jenkins"
    fill_in "Email", with: "leroy@jenkins.com"
    fill_in "Password", with: "!123abcd"
    fill_in "Confirm Password", with: "!123abcd"
  end

  def fill_in_personal_info
    fill_in "First Name", with: "Hey"
    fill_in "Last Name", with: "Bob"
    select "Male", from: "Gender"
    select "Mixed", from: "Ethnicity"
    select "Green", from: "Party"
    select "Some College", from: "Education"
    select "Hindu", from: "Religion"
    select "Married", from: "Relationship"
    fill_in "date_picker", with: "11/12/1492"
  end

  def fill_in_contact_info
    fill_in "Twitter", with: "my_twitter_name"
    fill_in "Phone", with: "1234567890"
    fill_in "Address", with: "1 Boweevil Lane"
    fill_in "City", with: "Meat Camp"
    select "North Carolina", from: "State"
    fill_in "Zip Code", with: "12345"
  end

  def choose_file_to_upload(file = "test.jpg")
    attach_file "user_profile_pic", "#{Rails.root}/spec/support/images/#{file}"
  end

  def create_account
    click_button "Create Account"
  end

  def create_account_with(options)
    confirm = options[:confirm] ? options[:confirm] : options[:password]
    fill_in "Username", with: options[:username]
    fill_in "Email", with: options[:email]
    fill_in "Password", with: options[:password]
    fill_in "Confirm Password", with: confirm
    create_account
  end
end

