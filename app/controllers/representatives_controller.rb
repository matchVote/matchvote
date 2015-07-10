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

  def edit_demographics
    rep = RepresentativePresenter.new(find_rep_by_id)
    render partial: "edit_demographics", locals: { rep: rep }
  end

  def update_demographics
    rep = RepresentativePresenter.new(find_rep_by_id)
    authorize rep, :edit?
    rep.update!(demographics_params)
    render partial: "demographics", locals: { rep: rep }
  end

  private
    def find_rep_by_id
      Representative.find(params[:id])
    end

    def find_rep_by_slug
      Representative.find_by(slug: params[:slug])
    end

    def demographics_params
      params.require(:representative).permit(:gender)
    end
end
