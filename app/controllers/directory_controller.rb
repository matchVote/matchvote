require "will_paginate/array"
require "#{Rails.root}/app/serializers/representative_serializer"

class DirectoryController < ApplicationController
  def index
    reps = Representative.all
    @filter_count = reps.size
    @reps = reps.map { |rep| serialize(rep) }
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
    current_user.followed_reps.pluck(:id)
  end

  def serialize(rep)
    RepresentativeSerializer.new(rep).add(
      user_following: followed_reps.include?(rep.id),
    ).as_json
  end
end
