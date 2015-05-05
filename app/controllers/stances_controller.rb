class StancesController < ApplicationController
  def index
    @categories = IssueCategory.all
    @agreeance_values = Stance.agreeance_values
    @importance_values = Stance.importance_values
  end
end
