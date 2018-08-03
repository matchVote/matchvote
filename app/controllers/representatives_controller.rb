require "#{Rails.root}/lib/us_states"

class RepresentativesController < ApplicationController
  def show
    @rep = RepresentativePresenter.new(find_rep_by_slug)
    @issues = IssueCategory.all
    @recent_articles = Article
      .joins(:article_representatives)
      .includes(:comments)
      .where("articles_representatives.representative_id = '#{@rep.id}'")
      .order(date_published: :desc)
      .limit(3)
      .map(&ArticlePresenter)
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
    rep.update!(filtered_params)
    render partial: "demographics", locals: { rep: rep }
  end

  def edit_biography
    rep = RepresentativePresenter.new(find_rep_by_id)
    render partial: "edit_bio_section", locals: { rep: rep, states: USStates.all }
  end

  def update_biography
    rep = RepresentativePresenter.new(find_rep_by_id)
    authorize rep, :edit?
    rep.update!(biography_params)
    render partial: "bio_section", locals: { rep: rep }
  end

  private
    def find_rep_by_id
      Representative.find(params[:id])
    end

    def find_rep_by_slug
      Representative.find_by(slug: params[:slug])
    end

    def demographics_params
      params.require(:representative).permit(
        :gender, :orientation, :religion, :birthday)
    end

    def biography_params
      params.require(:representative).permit(
        :biography, :party, :state, :government_role, :status)
    end

    def filtered_params
      formatter = DateFormatter.new(demographics_params[:birthday])
      demographics_params.merge(birthday: formatter.datepicker_to_standard)
    end
end
