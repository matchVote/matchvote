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
        author_line << "By #{article.authors.first}"
      end
      author_line << " at #{article.publisher}" unless article.publisher == "Reddit Politics"
    end
  end

  def published
    if article.date_published
      date = article.date_published.strftime("%B %-d, %Y")
      "#{date} - #{time_published}"
    end
  end

  def time_published
    article.date_published.strftime("%l:%M %p %Z")
  end

  def summary_points
    (article.summary || "").split("\\n")
  end

  def top_keywords
    article.keywords.take(5).map { |kw| kw.capitalize }
  end

  def bookmarked?(user)
    article.bookmarks.map(&:user_id).find { |id| id == user.id } if user
  end

  def remaining_comments_count(limit)
    num = article.comments.size - limit
    num < 0 ? 0 : num
  end

  def comment_box_text(user)
    if !user
      "Create a matchVote account to add your comment"
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

  def top_mentioned_rep
    @rep ||= begin
      reps = article.article_representatives.order(mentioned_count: :desc)
      RepresentativePresenter.new(reps.first.representative)
    end
  end

  def newsworthiness_increase?
    article.user_article_changes.exists?(change_type: "newsworthiness_increment")
  end

  def newsworthiness_decrease?
    article.user_article_changes.exists?(change_type: "newsworthiness_decrement")
  end

  def newsworthiness_classes(type, user)
    if user
      classes = []
      classes << "newsworthiness-selection" if send("newsworthiness_#{type}?")
      if send("newsworthiness_#{opposite_type(type)}?")
        classes << "newsworthiness-disabled nohover"
      end
      classes.join(" ")
    end
  end

  def has_pulse_poll_response?(user)
    PollResponse.exists?(user: user, article: article) if user
  end

  private

  def opposite_type(type)
    type == 'decrease' ? 'increase' : 'decrease'
  end
end
