require "will_paginate/array"

class DirectoryController < ApplicationController
  def index
    reps = Representative.includes(:stances)
    @reps = reps.map do |rep|
      calculator = MatchCalculator.new(rep.stances, current_user.stances)
      present(rep, calculator)
    end

    @sort_list = DirectoryPresenter.sort_list
    @filter_count = reps.size
  end

  private

  def per_page
    50
  end

  def find_reps(search)
    search.present? ? Representative.search_by_name(search) : Representative.all
  end

  def present(rep, calculator)
    presenter = RepresentativePresenter.new(rep, calculator.overall_percent)
    presenter.react_hash.merge(
      { user_following: rep.followers.exists?(current_user.id) }
    )
  end
end
