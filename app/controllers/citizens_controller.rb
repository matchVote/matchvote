class CitizensController < ApplicationController
  def show
    user = User.find_by!(username: params[:id])
    @citizen = CitizenPresenter.new(CitizenDecorator.new(user))
    @stances = StancesPresenter.new(Stance.stances_for_entity(user))
    @policy  = CitizenPolicy.new(current_user, user)
  end

  def edit
    user = User.find_by!(username: params[:id])
    authorize user
    @citizen = CitizenPresenter.new(CitizenDecorator.new(user))
    @stances = StancesPresenter.new(Stance.stances_for_entity(user))
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
    user.update!(citizen_params)
    render text: :success
  end

  private
    def citizen_params
      params.require(:user).permit(
        :profile_pic,
        personal_info: [
          :first_name, :last_name, :gender, :religion, :birthday,
          :ethnicity, :party, :education, :relationship, :bio])
    end

    def authorize(user)
      policy = CitizenPolicy.new(current_user, user)
      fail Pundit::NotAuthorizedError unless policy.edit?
    end
end
