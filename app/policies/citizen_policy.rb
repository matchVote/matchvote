class CitizenPolicy < ApplicationPolicy
  def edit?
    user.admin? || user.profile_id == record.id
  end
end

