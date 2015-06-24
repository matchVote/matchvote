require "support/page_objects/page"
require "support/wait_for_ajax"
require "support/helpers/rep_creator"

class DirectoryPage < Page
  include WaitForAjax
  include RepCreator
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def signin_and_visit
    sign_in
    visit
  end

  def visit
    page.visit root_path
  end

  def number_of_visible_reps
    all(".directory_block").size
  end

  def scroll_to_bottom_of_page
    execute_script "window.scrollBy(0, 10000)"
  end

  def search_for(text)
    fill_in :directory_search, with: text
    find("#directory_search_button").click
  end

  def has_content?(content)
    page.has_content?(content)
  end

  def has_pagination?
    has_selector?(".pagination")
  end
end

