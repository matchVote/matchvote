module ArticleCollection
  def collect_articles(params, user)
    filters = params.fetch(:filters, {})
    articles = join_comments(Article, params[:sort])
    articles = join_bookmarks(articles, filters[:bookmarks], user)
    articles = filter_by_dates(articles, filters[:dates_published].values)
    articles = filter_by_followed(articles, filters[:followed], user)
    articles = filter_by_rep(articles, filters[:rep])
    order(articles, params[:sort])
  end

  def normalize_dates(dates)
    dates ? dates.map { |d| Time.zone.parse(d) } : [Time.zone.now]
  end

  private

  def join_comments(articles, sort)
    if sort == 'comment_count'
      articles.joins('LEFT JOIN comments C on C.commentable_id = articles.id')
    else
      articles.includes(comments: { comments: { comments: :comments }})
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

  def filter_by_dates(articles, dates)
    dates = convert_to_ranges(normalize_dates(dates))
    articles.where(date_published: dates)
  end

  def convert_to_ranges(dates)
    dates.map { |date| date.beginning_of_day...date.end_of_day }
  end

  def filter_by_followed(articles, filter, user)
    if filter
      filter_by_rep_ids(articles, user.followed_reps)
    else
      articles
    end
  end

  def filter_by_rep(articles, rep_id)
    if rep_id
      filter_by_rep_ids(articles, [rep_id])
    else
      articles
    end
  end

  def filter_by_rep_ids(articles, ids)
    articles
      .joins(:article_representatives)
      .where(articles_representatives: { representative_id: ids })
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
