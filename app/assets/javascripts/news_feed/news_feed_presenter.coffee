$(document).on 'page:change', ->
  return unless $('#news-feed-presenter').length
  new NewsFeedPresenter()

class NewsFeedPresenter
  constructor: ->
    @$articleList = $('#article-list')
    @sortType = 'newest'
    @bindEvents()

  bindEvents: ->
    @sortArticles()

  sortArticles: ->
    $('.article-sort').change (event) =>
      $selectBox = $(event.target)
      @sortType = $selectBox.val()
      @$articleList.html('Status Spinner to go here')
      @executeAjaxRequest()

  executeAjaxRequest: ->
    $.ajax
      url: '/api/articles'
      data:
        sort: @sortType
      success: (articles_html) =>
        @$articleList.html(articles_html)
      error: ->
        console.log('Fail')
