$(document).on 'page:change', ->
  return unless $('#news-feed-presenter').length
  new NewsFeedPresenter()

class NewsFeedPresenter
  constructor: ->
    @$articleList = $('#article-list')
    @$mostMentions = $('#most-mentions')
    @$filterBookmarksButton = $('#filter-bookmarks')
    @$datepicker = $('#newsfeed-datepicker')
    @articlesIndex = '/api/articles'
    @isPaginating = false
    @sort = 'newsworthiness'
    @filters = {dates_published: [new Date()]}
    @bindEvents()
    @initializeDatepicker()

  bindEvents: ->
    @scrollingPagination()
    @sortArticles()
    @filterArticles()
    @filterBookmarks()
    @filterMostMentionedRep()
    @browseYesterday()

  initializeDatepicker: ->
    @$datepicker.datepicker
      endDate: 'tomorrow'
    @$datepicker.on 'changeDate', (event) =>
      if event.date
        @filters.dates_published.push(event.date)
      @updateArticles()

  updateArticles: ->
    @$articleList.html('')
    @$mostMentions.html('')
    $('.spinner').show()
    @executeAjaxRequest @articlesIndex, (response) =>
      @$articleList.html(response.articles)
      @updateStats(response.stats)
      @$mostMentions.html(response.most_mentions)

  updateStats: (stats) ->
    console.log(stats)
    days = stats.selected_dates[2018].join(', ')
    $('.selected-dates').text(days + ' 2018')
    $('#stats-current-date').text(stats.current_date)
    $('#stats-article-count').text(stats.article_count)
    count = stats.publisher_count
    text = if count == 1 then "1 source" else "#{count} sources"
    $('#publishers-link').text(text)

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
        @executeAjaxRequest url, (res) =>
          $('.pagination').remove()
          @$articleList.append(res.html)

  isHalfwayThroughList: ->
    $(window).scrollTop() > $(document).height() / 2

  sortArticles: ->
    $('.article-sort').change (event) =>
      $selectBox = $(event.target)
      @sort = $selectBox.val()
      @updateArticles()

  filterArticles: ->
    $('.article-filter').change (event) =>
      delete @filters.rep
      $selectBox = $(event.target)
      filter = $selectBox.val()
      if filter is 'all'
        delete @filters.followed
      else
        @filters[filter] = true
      @updateArticles()

  filterBookmarks: ->
    @$filterBookmarksButton.click =>
      if $('.glyphicon-log-in').length
        @sign_in_alert()
        return
      if 'bookmarks' of @filters
        @$filterBookmarksButton.addClass('btn-default')
        @$filterBookmarksButton.removeClass('label-info')
        delete @filters.bookmarks
      else
        @$filterBookmarksButton.addClass('label-info')
        @$filterBookmarksButton.removeClass('btn-default')
        @filters.bookmarks = true
      @updateArticles()

  sign_in_alert: ->
    sweetAlert {
      title: 'Not signed in',
      text: 'You must sign in or create an account to do that.',
      type: 'warning',
      confirmButtonText: 'Login or Create Account',
      showCancelButton: true,
      cancelButtonText: 'Cancel',
    }, () => window.location.href = @sign_in_path

  browseYesterday: ->
    $('#browse-yesterday').click =>
      now = new Date()
      @filters.date_published = new Date(
        now.getFullYear(),
        now.getMonth(),
        now.getDate() - 1
      )
      @updateArticles()
      delete @filters.date_published

  filterMostMentionedRep: ->
    $('#most-mentions').on 'click', '.mention_pic', (event) =>
      repID = $(event.target).data('rep-id')
      @filters.rep = repID
      delete @filters.followed
      @updateArticles()

