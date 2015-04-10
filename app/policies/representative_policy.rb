class RepresentativePolicy < ApplicationPolicy
  def update?
    user.admin?
  end
end
