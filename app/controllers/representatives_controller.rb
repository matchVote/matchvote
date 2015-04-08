class RepresentativesController < ApplicationController
  def show
    @rep = RepresentativePresenter.new(find_rep_by_slug)
    @issues = Issue.all
  end

  def edit
    @rep = RepresentativePresenter.new(find_rep_by_id)
    @issues = Issue.all
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
