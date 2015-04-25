require "will_paginate/array"

class DirectoryController < ApplicationController
  PER_PAGE = 100

  def index
    @reps = DirectoryPresenter.new(reps: Representative.all).reps.
      paginate(page: params[:page], per_page: PER_PAGE)
    @sort_list = DirectoryPresenter.sort_list
    @filter_count = Representative.count
  end

  def filter
    reps = DirectoryPresenter.new(
      reps: find_reps(params[:search]),
      sort_by: params[:sort]
    ).reps.paginate(page: params[:page], per_page: PER_PAGE)
    render partial: "reps_list", locals: { reps: reps }
  end

  private
    def find_reps(search)
      search.present? ? Representative.search_by_name(search) : Representative.all
    end
end

