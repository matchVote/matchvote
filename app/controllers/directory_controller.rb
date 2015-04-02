class DirectoryController < ApplicationController
  def index
    @reps = DirectoryPresenter.new.all_reps
    @sort_list = DirectoryPresenter.sort_list
    @filter_count = Representative.count
  end

  def sort_reps
    reps = DirectoryPresenter.new(sort_reps_by: params[:sort]).all_reps
    render partial: "reps_list", locals: { reps: reps }
  end
end

