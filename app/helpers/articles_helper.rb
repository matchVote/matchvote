module ArticlesHelper
  def render_articles(articles, comment_limit, reply_limit)
    articles.map do |article|
      render "newscard",
        article: article,
        comment_limit: comment_limit,
        reply_limit: reply_limit
    end
  end

  def self.current_date(zone_time = Time.zone.now)
    "#{zone_time.strftime("%B")} #{zone_time.day.ordinalize}, #{zone_time.year}"
  end

  def current_date
    ArticlesHelper.current_date
  end
end
