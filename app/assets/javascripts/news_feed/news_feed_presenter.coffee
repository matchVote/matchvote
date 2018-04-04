$(document).on 'page:change', ->
  return unless $('#news-feed-presenter').length
  new NewsFeedPresenter()

class NewsFeedPresenter
  constructor: ->
    @$articleList = $('#article-list')
    @$filterBookmarksButton = $('#filter-bookmarks')
    @$pastNewsButton = $('#past-news')
    @$datepicker = $('#newsfeed-datepicker')
    @articlesIndex = '/api/articles'
    @isPaginating = false
    @sort = 'newest'
    @filters = {}
    @bindEvents()
    @fetchStats()
    @initializeDatepicker()

  bindEvents: ->
    @scrollingPagination()
    @sortArticles()
    @filterArticles()
    @filterBookmarks()
    @filterByDate()

  fetchStats: ->
    $.ajax
      url: 'api/news_feed_stats'
      success: (html) =>
        $('.article_count').html(html)
      error: (xhr, status, error) ->
        console.log("Fail -- status: #{status}; error #{error}")

  initializeDatepicker: ->
    @$datepicker.datepicker
      endDate: 'tomorrow'
    @$datepicker.on 'changeDate', (event) =>
      if event.date
        @filters.date_published = event.date
      @updateArticles()

  updateArticles: ->
    @$articleList.html('')
    $('.spinner').show()
    @executeAjaxRequest @articlesIndex, (html) =>
      @$articleList.html(html)

  executeAjaxRequest: (url, articles_callback) ->
    $.ajax
      url: url
      data:
        sort: @sort
        filters: @filters
      success: (articles_html) =>
        $('.spinner').hide()
        articles_callback(articles_html)
        @isPaginating = false
      error: (xhr, status, error) ->
        console.log("Fail -- status: #{status}; error #{error}")

  scrollingPagination: ->
    $(window).scroll =>
      url = $('.pagination .next_page').attr('href')
      if url and @isHalfwayThroughList() and not @isPaginating
        @isPaginating = true
        $('.spinner').show()
        @executeAjaxRequest url, (html) =>
          $('.pagination').remove()
          @$articleList.append(html)

  isHalfwayThroughList: ->
    $(window).scrollTop() > $(document).height() / 2

  sortArticles: ->
    $('.article-sort').change (event) =>
      $selectBox = $(event.target)
      @sort = $selectBox.val()
      @updateArticles()

  filterArticles: ->
    $('.article-filter').change (event) =>
      $selectBox = $(event.target)
      console.log("Filtering on: #{$selectBox.val()}")
      filter = $selectBox.val()
      if filter is 'all'
        delete @filters.followed
      else
        @filters[filter] = true
      @updateArticles()

  filterBookmarks: ->
    @$filterBookmarksButton.click =>
      if 'bookmarks' of @filters
        @$filterBookmarksButton.addClass('btn-default')
        @$filterBookmarksButton.removeClass('label-info')
        delete @filters.bookmarks
      else
        @$filterBookmarksButton.addClass('label-info')
        @$filterBookmarksButton.removeClass('btn-default')
        @filters.bookmarks = true
      @updateArticles()

  filterByDate: ->
    @$pastNewsButton.click (event) =>
      if 'date_published' of @filters
        @$datepicker.hide()
        @$pastNewsButton.addClass('btn-default')
        @$pastNewsButton.removeClass('label-info')
        delete @filters.date_published
        @$datepicker.datepicker('clearDates')
      else
        @$pastNewsButton.addClass('label-info')
        @$pastNewsButton.removeClass('btn-default')
        @$datepicker.show()
        @filters.date_published = true
