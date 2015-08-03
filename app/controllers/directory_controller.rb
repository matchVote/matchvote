require "will_paginate/array"

class DirectoryController < ApplicationController
  def index
    reps = Representative.includes(:stances)
    @reps = reps.map do |rep|
      calculator = MatchCalculator.new(rep.stances, current_user.stances)
      RepresentativePresenter.new(rep, calculator.overall_percent).react_hash
    end

    @sort_list = DirectoryPresenter.sort_list
    @filter_count = reps.size
  end

  # def old_index
  #   @reps = DirectoryPresenter.new(
  #     reps: Representative.includes(:stances),
  #     user: current_user
  #   ).reps.paginate(page: params[:page], per_page: per_page)
  #   @sort_list = DirectoryPresenter.sort_list
  #   @filter_count = Representative.count
  # end

  # def filter
  #   reps = DirectoryPresenter.new(
  #     reps: find_reps(params[:search]),
  #     sort_by: params[:sort],
  #     user: current_user
  #   ).reps.paginate(page: params[:page], per_page: per_page)
  #   render partial: "reps_list", locals: { reps: reps }
  # end

  private
    def per_page
      50
    end

    def find_reps(search)
      search.present? ? Representative.search_by_name(search) : Representative.all
    end
end

