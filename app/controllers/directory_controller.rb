class DirectoryController < ApplicationController
  def index
    @reps = DirectoryPresenter.new.reps
    @sort_list = DirectoryPresenter.sort_list
    @filter_count = Representative.count
  end

  def sort_reps
    reps = DirectoryPresenter.new(sort_by: params[:sort]).reps
    render partial: "reps_list", locals: { reps: reps }
  end

  def search
    reps = DirectoryPresenter.new.present(Representative.search(params[:search]))
    render partial: "reps_list", locals: { reps: reps }
  end
end

