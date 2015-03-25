class RepresentativeController < ApplicationController
  def show
    name = params[:full_name].split("-")
    @rep = Representative.find_by(first_name: name.first, last_name: name.last)
  end

  private
    def rep_params
      params.require(:representative).permit(:full_name)
    end
end
