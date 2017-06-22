class ArticlePresenter < SimpleDelegator
  def article
    @article ||= __getobj__
  end

  def read_time
    "#{article.read_time} read time"
  end

  def authored_by
    "By #{article.authors.join(",")} at #{article.publisher}"
  end

  def published
    "#{article.date_published} @ #{article.created_at.strftime("%I:%M:%S %p %Z")}"
  end

  def summary_points
    article.summary.split("\\n")
  end

  def top_keywords
    article.keywords.take(5).map { |kw| kw.capitalize }
  end

  def bookmarked?(user)
    article.bookmarks.exists?(user_id: user.id)
  end

  def remaining_comments_count(limit)
    num = article.comments.size - limit
    num < 0 ? 0 : num
  end
end
