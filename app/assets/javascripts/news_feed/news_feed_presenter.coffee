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
    @today = new Date()
    @filters = {dates_published: [@today]}
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
      pickedDates = @$datepicker.datepicker('getDates')
      @filters.dates_published = [@today].concat(pickedDates)
      @updateArticles()

  updateArticles: (refreshMostMentioned = true) ->
    @$articleList.html('')
    if refreshMostMentioned
      @$mostMentions.html('')
      delete @filters.rep
    $('.spinner').show()
    @executeAjaxRequest @articlesIndex, (response) =>
      @$articleList.html(response.articles)
      @updateStats(response.stats)
      @$mostMentions.html(response.most_mentions) if refreshMostMentioned

  updateStats: (stats) ->
    days = @formatDays(stats.selected_dates)
    $('.selected-dates').text(days)
    datesText = if days then "for #{days}" else ''
    $('#stats-selected-dates').text(datesText)
    $('#stats-article-count').text(stats.article_count)
    count = stats.publisher_count
    text = if count == 1 then "1 source" else "#{count} sources"
    $('#publishers-link').text(text)

  formatDays: (dates) ->
    if dates
      days = ("#{month[0]} #{month[1].join(', ')}" for month in dates[2018])
      return days.join(', ') + ', 2018'
    ''

  executeAjaxRequest: (url, articles_callback) ->
    $.ajax
      url: url
      data:
        sort: @sort
        filters: @filters
      success: (data) =>
        $('.spinner').hide()
        articles_callback(data.articles)
        @isPaginating = false
      error: (xhr, status, error) ->
        console.log("Fail -- status: #{status}; error #{error}")

  scrollingPagination: ->
    $(window).scroll =>
      url = $('.pagination .next_page').attr('href')
      if url and @isHalfwayThroughList() and not @isPaginating
        @isPaginating = true
        $('.spinner').show()
        @executeAjaxRequest url, (articles_html) =>
          $('.pagination').remove()
          @$articleList.append(articles_html)

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
      if 'bookmarks' of @filters
        @$filterBookmarksButton.addClass('btn-default')
        @$filterBookmarksButton.removeClass('label-info')
        delete @filters.bookmarks
      else
        @$filterBookmarksButton.addClass('label-info')
        @$filterBookmarksButton.removeClass('btn-default')
        @filters.bookmarks = true
      @updateArticles()

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
      selected = $(event.target)
      selected.parent().removeClass('faded')
      repID = selected.data('rep-id')
      if @filters.rep == repID
        $('#most-mentions .col').each (_, elem) ->
          $(elem).removeClass('faded')
        delete @filters.rep
      else
        $('#most-mentions .col').each (_, elem) ->
          rep = $(elem)
          id = rep.children('.mention_pic').first().data('rep-id')
          rep.addClass('faded') unless id == repID
        @filters.rep = repID
        delete @filters.followed
      @updateArticles(false)

