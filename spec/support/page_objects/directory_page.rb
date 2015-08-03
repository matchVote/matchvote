require "support/page_objects/page"
require "support/wait_for_ajax"
require "support/helpers/rep_creator"
require "support/helpers/stance_helper"

class DirectoryPage < Page
  include WaitForAjax
  include RepCreator

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
  end

  def has_content?(content)
    page.has_content?(content)
  end

  def has_pagination?
    has_selector?(".pagination")
  end

  def create_stances_for_matching(reps, user)
    helper = StanceHelper.new
    statements = helper.build_statements
    helper.create_stances_for(statements, user,    [[1,2], [2,2], [-3,1], [-1,1]])

    helper.create_stances_for(statements, reps[0], [[1,2], [2,1], [-3,2], [-2,0]])
    helper.create_stances_for(statements, reps[1], [[1,2], [2,1], [-3,2], [-1,2]])
    helper.create_stances_for(statements, reps[2], [[1,2], [2,1], [ 1,2], [-3,0]])
    helper.create_stances_for(statements, reps[3], [[1,2], [1,1], [ 3,2], [-2,2]])
    helper.create_stances_for(statements, reps[4], [[2,2], [2,1], [ 2,2], [ 1,0]])
  end
end

