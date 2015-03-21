class RepresentativeController < ApplicationController
  def show
    name = params[:full_name].split("-")
    @rep = Representative.find_by(first_name: name.first.capitalize,
                                  last_name: name.last.capitalize)
  end

  private
    def rep_params
      params.require(:representative).permit(:full_name)
    end
end
