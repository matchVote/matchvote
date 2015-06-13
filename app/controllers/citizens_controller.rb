require "#{Rails.root}/lib/us_states"

class CitizensController < ApplicationController
  def show
    user = User.find_by!(username: params[:id])
    @citizen = CitizenPresenter.new(user)
    @stances = StancesPresenter.new(Stance.stances_for_entity(user))
    @policy  = CitizenPolicy.new(current_user, user)
  end

  def edit
    user = User.find_by!(username: params[:id])
    authorize user
    @citizen = CitizenPresenter.new(user)
    @stances = StancesPresenter.new(Stance.stances_for_entity(user))
    @all_states = USStates.all
  end

  def update
    user = User.find_by!(username: params[:id])
    authorize user
    user.update!(citizen_params)
    flash[:notice] = "Profile updated successfully."
    redirect_to edit_citizen_path(user)
  end

  def update_personal_info
    user = User.find(params[:id])
    authorize user
    CitizenUpdater.new(user).update_personal_info(citizen_params[:personal_info])
    render text: :success
  end

  def update_contact_info
    user = User.find(params[:id])
    authorize user
    CitizenUpdater.new(user).update_contact(citizen_params[:contact_attributes])
    render text: :success
  end

  private
    def citizen_params
      params.require(:user).permit(
        :profile_pic,
        personal_info: [
          :first_name, :last_name, :gender, :religion, :birthday,
          :ethnicity, :party, :education, :relationship, :bio],
        contact_attributes: [
          :id,
          external_ids: [:twitter_username],
          phone_numbers: [],
          postal_addresses_attributes: [:id, :line1, :city, :state, :zip]
        ])
    end

    def authorize(user)
      policy = CitizenPolicy.new(current_user, user)
      fail Pundit::NotAuthorizedError unless policy.edit?
    end
end
