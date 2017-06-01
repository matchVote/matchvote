class ArticlesController < ApplicationController
  def newsworthiness
    # authorize
    Article.send("#{params[:type]}_counter", :newsworthiness_count, params[:id])
    render json: { status: "OK" }
  end
end
