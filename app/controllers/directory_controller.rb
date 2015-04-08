class DirectoryController < ApplicationController
  def index
    @reps = DirectoryPresenter.new.reps
    @sort_list = DirectoryPresenter.sort_list
    @filter_count = Representative.count
  end

  def filter
    parameters = { sort_by: params[:sort], search_name: params[:search] }
    reps = DirectoryPresenter.new(parameters).reps
    render partial: "reps_list", locals: { reps: reps }
  end
end

