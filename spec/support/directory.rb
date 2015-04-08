def search_for(text)
  fill_in :directory_search, with: text
  find("#directory_search_button").click
end

