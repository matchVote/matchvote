module ArticleCollection
  def collect_articles(params, user)
    filters = params.fetch(:filters, {})
    articles = join_comments(Article, params[:sort])
    articles = join_bookmarks(articles, filters[:bookmarks], user)
    articles = filter_by_date(articles, normalize_date(filters[:date_published]))
    order(articles, params[:sort])
  end

  private

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
      articles = articles.includes(:bookmarks)
    end
  end

  def filter_by_date(articles, date)
    articles.where(date_published: date.beginning_of_day...date.end_of_day)
  end

  def order(articles, sort)
    if sort == 'comment_count'
      articles.group('articles.id').order('count(C.id) DESC')
    else
      sort = sort || 'newest'
      articles.order(sort_mapping[sort] => :desc)
    end
  end

  def sort_mapping
    { 'newest' => 'date_published',
      'newsworthiness' => 'newsworthiness_count',
      'most_read' => 'read_count' }
  end

  def normalize_date(date)
    date ? Time.parse(date) : Time.now
  end
end
