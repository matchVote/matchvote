class DirectoryController < ApplicationController
  def index
    @reps = DirectoryPresenter.new(reps: Representative.limit(10)).reps
    @sort_list = DirectoryPresenter.sort_list
    @filter_count = Representative.count
  end

  def filter
    reps = DirectoryPresenter.new(
      reps: Representative.search_by_name(params[:search]),
      sort_by: params[:sort]
    ).reps
    render partial: "reps_list", locals: { reps: reps }
  end
end

