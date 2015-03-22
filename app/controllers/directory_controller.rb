class DirectoryController < ApplicationController
  def index
    @reps = Representative.all
    @sort_list = [
      ["Alphabetically", "alphabetically"],
      ["Similarity", "similarity"]
    ]
  end
end
