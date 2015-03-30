class DirectoryController < ApplicationController
  def index
    @reps = Representative.all.map { |r| RepresentativePresenter.new(r) }
    @sort_list = DirectoryPresenter.sort_list
    @filter_count = Representative.count
  end
end

