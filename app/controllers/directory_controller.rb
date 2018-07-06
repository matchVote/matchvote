require "will_paginate/array"

class DirectoryController < ApplicationController
  def index
    reps = Representative.all
    @filter_count = reps.size
    @reps = reps.map { |rep| present(rep) }
    @sort_list = DirectoryPresenter.sort_list
  end

  private

  def per_page
    50
  end

  def find_reps(search)
    search.present? ? Representative.search_by_name(search) : Representative.all
  end

  def followed_reps
    @ids ||= current_user.followed_reps.pluck(:id)
  end

  def present(rep)
    presenter = RepresentativePresenter.new(rep)
    presenter.react_hash.merge(
      { user_following: followed_reps.include?(rep.id) }
    )
  end
end
