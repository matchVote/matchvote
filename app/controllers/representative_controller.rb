class RepresentativeController < ApplicationController
  def show
    @rep = RepresentativePresenter.new(find_rep)
    @issues = Issue.all
  end

  private
    def find_rep
      name = params[:full_name].split("-")
      Representative.find_by(first_name: name.first, last_name: name.last)
    end

    def rep_params
      # params.require(:representative).permit(:full_name)
    end
end
