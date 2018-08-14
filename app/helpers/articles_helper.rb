require 'set'

module ArticlesHelper
  def render_articles(articles, comment_limit, reply_limit)
    articles.map do |article|
      render "newscard",
        article: article,
        comment_limit: comment_limit,
        reply_limit: reply_limit
    end
  end

  def self.format_dates(dates)
    initial = Hash.new { |hash, key| hash[key] = Set[] }
    dates.reduce(initial) do |hash, date|
      hash[date.year] << "#{date.strftime("%B")} #{date.day.ordinalize}"
      hash
    end
  end

  def current_date
    date = Time.zone.now
    "#{date.strftime("%B")} #{date.day.ordinalize}, #{date.year}"
  end
end
