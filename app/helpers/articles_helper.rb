module ArticlesHelper
  def render_articles(articles, comment_limit, reply_limit)
    articles.map do |article|
      render "newscard",
        article: article,
        comment_limit: comment_limit,
        reply_limit: reply_limit
    end
  end
end
