class RepresentativePolicy < ApplicationPolicy
  def update?
    user.admin? || user.id == record.user_id
  end
end
