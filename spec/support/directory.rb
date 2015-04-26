def search_for(text)
  fill_in :directory_search, with: text
  find("#directory_search_button").click
end

def scroll_to_bottom_of_page
  subject.execute_script "window.scrollBy(0, 10000)"
end

