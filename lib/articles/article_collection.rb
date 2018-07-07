module ArticleCollection
  module_function

  def collect_articles(params, user)
    filters = params.fetch(:filters, {})
    articles = join_comments(Article, params[:sort])
    articles = join_bookmarks(articles, filters[:bookmarks], user)
    articles = filter_by_date(articles, normalize_date(filters[:date_published]))
    articles = filter_by_followed(articles, filters[:followed], user)
    order(articles, params[:sort])
  end

  def normalize_date(date)
    date ? Time.zone.parse(date) : Time.zone.now
  end

  def join_comments(articles, sort)
    if sort == 'comment_count'
      articles.joins('LEFT JOIN comments C on C.commentable_id = articles.id')
    else
      articles.includes(:comments)
    end
  end

  def join_bookmarks(articles, filter, user)
    if filter
      articles = articles.joins(:bookmarks)
      articles.where(bookmarks: { user_id: user.id })
    else
      articles.includes(:bookmarks)
    end
  end

  def filter_by_date(articles, date)
    articles.where(date_published: date.beginning_of_day...date.end_of_day)
  end

  def filter_by_followed(articles, filter, user)
    if filter
      articles
        .joins(:article_representatives)
        .where(articles_representatives: { representative_id: user.followed_reps })
    else
      articles
    end
  end

  def order(articles, sort)
    if sort == 'comment_count'
      articles.group('articles.id').order('count(C.id) DESC')
    else
      articles.order(sort_mapping[sort || 'newest'] => :desc)
    end
  end

  def sort_mapping
    { 'newest' => 'date_published',
      'newsworthiness' => 'newsworthiness_count',
      'most_read' => 'read_count' }
  end
end
