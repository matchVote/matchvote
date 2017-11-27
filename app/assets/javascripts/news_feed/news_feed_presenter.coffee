$(document).on 'page:change', ->
  return unless $('#news-feed-presenter').length
  new NewsFeedPresenter()

class NewsFeedPresenter
  constructor: ->
    @$articleList = $('#article-list')
    @$filterBookmarksButton = $('#filter-bookmarks')
    @articlesIndex = '/api/articles'
    @isPaginating = false
    @sort = 'newest'
    @filter = null
    @bindEvents()

  bindEvents: ->
    @scrollingPagination()
    @sortArticles()
    @filterBookmarks()

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
      @$articleList.html('')
      $('.spinner').show()
      @executeAjaxRequest @articlesIndex, (html) =>
        @$articleList.html(html)

  filterBookmarks: ->
    @$filterBookmarksButton.click =>
      if @filter is 'bookmarks'
        @filter = null
        @$filterBookmarksButton.addClass('btn-default')
        @$filterBookmarksButton.removeClass('label-info')
      else
        @filter = 'bookmarks'
        @$filterBookmarksButton.addClass('label-info')
        @$filterBookmarksButton.removeClass('btn-default')
      @$articleList.html('')
      $('.spinner').show()
      @executeAjaxRequest @articlesIndex, (html) =>
        @$articleList.html(html)

  executeAjaxRequest: (url, articles_callback) ->
    $.ajax
      url: url
      data:
        sort: @sort
        filter: @filter
      success: (articles_html) =>
        $('.spinner').hide()
        articles_callback(articles_html)
        @isPaginating = false
      error: (xhr, status, error) ->
        console.log("Fail -- status: #{status}; error #{error}")
