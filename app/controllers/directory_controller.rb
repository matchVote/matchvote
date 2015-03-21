class DirectoryController < ApplicationController
  def index
    @reps = Representative.all
  end
end
