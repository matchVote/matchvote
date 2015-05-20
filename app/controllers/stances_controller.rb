class StancesController < ApplicationController
  def index
    @categories = IssueCategory.all
  end

  def create
    stance_attrs = normalize(stance_params).merge(opinionable: current_user)
    stance = Stance.create!(stance_attrs)
    render partial: "update_stance_button", locals: { stance: stance }
  end

  def update
    stance = Stance.find(params[:id])
    authorize stance
    stance.update_attributes(normalize(stance_params))
    render text: :success
  end

  def destroy
    stance = Stance.find(params[:id])
    authorize stance
    stance.destroy
    render partial: "statement", 
      locals: { statement: stance.statement, stance: Stance.new }
  end

  private
    def stance_params
      params.require(:stance).permit(
        :agreeance_value, 
        :importance_value,
        :statement_id)
    end

    def normalize(stance_params)
      stance_params.each { |k,v| stance_params[k] = v.to_i }
    end
end
