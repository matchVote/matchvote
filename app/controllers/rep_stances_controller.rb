class RepStancesController < ApplicationController
  def index
    @categories = IssueCategory.all
  end
end
