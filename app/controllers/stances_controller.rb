class StancesController < ApplicationController
  def index
    @categories = IssueCategory.all
    @agreeance_values = Stance.agreeance_values
    @importance_values = Stance.importance_values
  end

  def create
    Stance.create!(stance_params.merge(
      agreeance_value: stance_params[:agreeance_value].to_i,
      importance_value: stance_params[:importance_value].to_i,
      opinionable_id: current_user.profile_id,
      opinionable_type: current_user.profile_type))
    render partial: "update_stance_button"
  end

  def update
  end

  private
    def stance_params
      params.require(:stance).permit(
        :agreeance_value, 
        :importance_value,
        :statement_id)
    end
end
