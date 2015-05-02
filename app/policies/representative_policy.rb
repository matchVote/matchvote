class RepresentativePolicy < ApplicationPolicy
  def update?
    user.admin? || user.profile_id == record.id
  end
end
