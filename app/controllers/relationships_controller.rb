class RelationshipsController < ApplicationController
  def create
    Relationship.create!(follower: current_user, followed: followed)
    render partial: "unfollow_button", locals: { followed: followed }
  end

  def unfollow
    Relationship.destroy_all(follower: current_user, followed: followed)
    render partial: "follow_button", locals: { followed: followed }
  end

  private

  def followed
    Representative.find(params[:relationship][:followed_id])
  end
end
