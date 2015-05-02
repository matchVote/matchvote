class RepresentativesController < ApplicationController
  def show
    @rep = RepresentativePresenter.new(find_rep_by_slug)
    @issues = IssueCategory.all
  end

  def edit
    rep = find_rep_by_id
    authorize rep
    @rep = RepresentativePresenter.new(rep)
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
