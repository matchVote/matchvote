class ArticlePresenter < SimpleDelegator
  def self.to_proc
    -> (article) { self.new(article) }
  end

  def article
    @article ||= __getobj__
  end

  def read_time
    String.new.tap do |time|
      time << "#{article.read_time} min " if article.read_time
      time << "Read"
    end
  end

  def authored_by
    String.new.tap do |author_line|
      if !article.authors.empty?
        author_line << "By #{article.authors.first} at "
      end
      author_line << article.publisher
    end
  end

  def published
    if article.date_published
      date = article.date_published.strftime("%B %-d, %Y")
      time = article.date_published.strftime("%l:%M %p %Z")
      "#{date} - #{time}"
    end
  end

  def summary_points
    (article.summary || "").split("\\n")
  end

  def top_keywords
    article.keywords.take(5).map { |kw| kw.capitalize }
  end

  def bookmarked?(user)
    article.bookmarks.map(&:user_id).find { |id| id == user.id }
  end

  def remaining_comments_count(limit)
    num = article.comments.size - limit
    num < 0 ? 0 : num
  end

  def comment_box_text(user)
    if user.account.standard?
      "Upgrade to matchVote Premium to add your comment"
    else
      "Add your comment"
    end
  end

  def newsworthiness_count
    article.newsworthiness_count || 0
  end

  def mentioned_reps
    article.article_representatives.map do |article_rep|
      RepresentativePresenter.new(article_rep.representative)
    end
  end

  def newsworthiness_increase?
    article.user_article_changes.exists?(change_type: "newsworthiness_increment")
  end

  def newsworthiness_decrease?
    article.user_article_changes.exists?(change_type: "newsworthiness_decrement")
  end

  def newsworthiness_classes(type)
    classes = []
    classes << "newsworthiness-selection" if send("newsworthiness_#{type}?")
    if send("newsworthiness_#{opposite_type(type)}?")
      classes << "newsworthiness-disabled nohover"
    end
    classes.join(" ")
  end

  private

  def opposite_type(type)
    type == 'decrease' ? 'increase' : 'decrease'
  end
end
