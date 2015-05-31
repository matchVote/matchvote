class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_stances_presenter

  def new
    @signup_form = SignUpForm.new
    super
  end

  def create
    new_params = sign_up_params.except(:password, :password_confirmation)
    @signup_form = SignUpForm.new(new_params)
    super
  end

  protected
    def after_sign_up_path_for(resource)
      stances_path
    end

    def sign_up_params
      params.require(resource_name).permit(
        :username, :email, :password, :password_confirmation, 
        personal_info: [
          :first_name, :last_name, :gender, :religion,
          :ethnicity, :party, :education, :relationship],
        contact_attributes: [
          external_ids: [:twitter],
          phone_numbers: [], 
          postal_addresses_attributes: [:line1, :city, :state, :zip]
        ])
    end

  private
    def set_stances_presenter
      # stances = Stance.includes(statement: :issue_category).
      #   where(opinionable: resource).order("issue_categories.name")
      # @stances = StancesPresenter.new(stances)
      @stances = StancesPresenter.new(Stance.stances_for_entity(resource))
    end
end

