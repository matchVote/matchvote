require 'set'

module ArticlesHelper
  def render_articles(articles, comment_limit, reply_limit)
    articles.map do |article|
      render 'newscard',
        article: article,
        comment_limit: comment_limit,
        reply_limit: reply_limit
    end
  end

  def self.format_dates(dates)
    years = Hash.new { |hash, key| hash[key] = [] }
    dates.sort.reduce(years) do |hash, date|
      months = hash[date.year]
      month_name = date.strftime('%B')
      month = months.find { |m| m.first == month_name }
      months << month = [month_name, Set[]] if month.nil?
      month.last << date.day.ordinalize
      hash
    end
  end

  def current_date
    date = Time.zone.now
    "#{date.strftime("%B")} #{date.day.ordinalize}, #{date.year}"
  end
end
