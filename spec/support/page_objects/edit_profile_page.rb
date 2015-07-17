require "support/page_objects/page"

class EditProfilePage < Page
  def visit
    page.visit edit_citizen_path(user)
  end

  def signin_and_visit
    sign_in
    visit
  end

  def refresh
    visit
  end

  def view_profile
    click_link "view_profile_link"
  end

  def privacy_settings_modal
    PrivacySettingsModal.new
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

  def update_personal_info
    within "#citizen_personal_info" do
      fill_in "First Name", with: "Hey"
      fill_in "Last Name", with: "BobbyJoe"
      select "Male", from: "Gender"
      select "Mixed", from: "Ethnicity"
      select "Democrat", from: "Party"
      select "Some College", from: "Education"
      select "Hindu", from: "Religion"
      select "Married", from: "Relationship"
      fill_in "date_picker", with: "11/12/1492"
      fill_in "biography", with: "Nice bio"
      click_button "Update"
    end
  end

  def update_contact_info
    within "#citizen_contact_info" do
      fill_in "Phone", with: "1231231231"
      fill_in "Twitter", with: "flippy"
      fill_in "Address", with: "5 Blueberry Circle"
      fill_in "City", with: "Panang"
      select "Wyoming", from: "State"
      fill_in "Zip Code", with: "21212"
      click_button "Update"
    end
  end

  def toggle_stances(action, issue:)
    within ".issue[data-issue-id='#{issue.id}']" do
      click_link action
    end
    sleep 0.5
  end

  def has_aws_url_for_profile_pic?
    profile_pic_url.match(/s3\.amazonaws\.com\/uploads\/user\/profile_pic/)
  end

  def has_default_pic?
    profile_pic_url == "/assets/default.png"
  end

  def has_personal_info?
    within "#citizen_personal_info" do
      find_field(:first_name).value == "Bob"
      find_field(:last_name).value == "Jenkins"
      find_field(:last_name).value == "hey there"
      find_field(:birthday).value == "11/12/1987"
      has_select? "party", selected: "Green"
    end
  end

  def has_contact_info?
    within "#citizen_contact_info" do
      find_field(:phone_number).value == "123-123-1234"
      find_field(:line1).value == "123 Herbib Drive"
      find_field(:city).value == "Metropolis"
      find_field(:state).value == "ND"
      find_field(:zip).value == "12345"
      find_field(:twitter_username).value == "tweet"
    end
  end

  def has_collapse_button?(issue:)
    within ".issue[data-issue-id='#{issue.id}']" do
      find(".toggle_stances_link").text == "Collapse"
    end
  end
end

