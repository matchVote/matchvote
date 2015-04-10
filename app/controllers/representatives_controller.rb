class RepresentativesController < ApplicationController
  include Pundit

  def show
    @rep = RepresentativePresenter.new(find_rep_by_slug)
    @view = RepProfileView.new(Pundit.policy!(current_user, @rep))
    @issues = IssueCategory.all
  end

  def edit
    @rep = RepresentativePresenter.new(find_rep_by_id)
    @issues = IssueCategory.all
  end

  def update
  end

  private
    def find_rep_by_id
      Representative.find(params[:id])
    end

    def find_rep_by_slug
      Representative.find_by(slug: params[:slug])
    end
end
