class RepresentativeController < ApplicationController
  def show
    @rep = RepresentativePresenter.new(find_rep)
    @issues = Issue.all
  end

  private
    def find_rep
      Representative.find_by(slug: params[:slug])
    end
end
