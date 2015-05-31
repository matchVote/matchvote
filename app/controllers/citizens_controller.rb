class CitizensController < ApplicationController
  def show
    user = User.find_by!(username: params[:id])
    @citizen = CitizenPresenter.new(user)
    @stances = StancesPresenter.new(Stance.stances_for_entity(user))
    @policy  = CitizenPolicy.new(current_user, user)
  end
end

