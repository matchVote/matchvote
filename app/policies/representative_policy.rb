class RepresentativePolicy < ApplicationPolicy
  def edit?
    user.admin? || (user.rep_admin? && user.profile_id == record.id)
  end
end
