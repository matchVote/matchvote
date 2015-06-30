require "support/page_objects/page"
require "support/wait_for_ajax"
require "support/helpers/rep_creator"
require "support/helpers/stance_helper"

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

  alias_method :refresh, :visit

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

  def create_stances_for_matching(reps, user)
    helper = StanceHelper.new
    user_stances = [[1,4], [2,1], [-3,2], [-1,0]]

    helper.create_stances_for(reps[0], user, 
      one: [[1,4], [2,1], [-3,2], [-2,0]], 
      two: user_stances)
    helper.create_stances_for(reps[1], user, 
      one: [[1,4], [2,1], [-3,2], [-1,0]], 
      two: user_stances)
    helper.create_stances_for(reps[2], user, 
      one: [[1,4], [2,1], [1,2], [-3,0]], 
      two: user_stances)
    helper.create_stances_for(reps[3], user, 
      one: [[1,4], [1,1], [3,2], [-2,0]], 
      two: user_stances)
    helper.create_stances_for(reps[4], user, 
      one: [[2,4], [0,1], [2,2], [1,0]], 
      two: user_stances)
  end
end

