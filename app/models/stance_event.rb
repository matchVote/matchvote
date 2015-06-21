class StanceEvent < ActiveRecord::Base
  belongs_to :stance
  belongs_to :statement
  belongs_to :issue_category
  belongs_to :opinionable, polymorphic: true

  enum action: [:created, :updated, :deleted]

  def self.log(action, stance, current_user)
    create do |event|
      event.action = action
      event.agreeance_value = stance.agreeance_value
      event.importance_value = stance.importance_value
      event.stance = stance
      event.statement = stance.statement
      event.issue_category = stance.issue_category
      event.opinionable = stance.opinionable
      event.created_by = current_user.id
    end
  end
end

