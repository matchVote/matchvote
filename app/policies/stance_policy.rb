class StancePolicy < ApplicationPolicy
  def update?
    record.opinionable_id == user.id
  end
end
