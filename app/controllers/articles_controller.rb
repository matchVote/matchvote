class ArticlesController < ApplicationController
  def newsworthiness
    # authorize
    article = Article.find(params[:id])
    count = article.newsworthiness_count
    count = params[:type] == "increase" ? count + 1 : count - 1
    article.update(newsworthiness_count: count)
    render json: { count: article.newsworthiness_count }
  end
end
