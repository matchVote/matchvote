class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_stances_presenter

  private
    def set_stances_presenter
      stances = Stance.includes(statement: :issue_category).
        where(opinionable: resource).order("issue_categories.name")
      @stances_presenter = StancesPresenter.new(stances)
    end
end

