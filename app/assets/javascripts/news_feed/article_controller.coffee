$(document).on "page:change", ->
  return unless $("#article-list").length
  new ArticleController()

class ArticleController
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @newsworthinessChange()
    @toggleBookmark()
    @showComments()
    @hideComments()
    @incrementReadCount()

  articleID: (event) ->
    $(event.target).closest(".newscard").attr("id")

  newsworthinessChange: ->
    $("#article-list").on "click", ".newsworthiness", (event) =>
      target = $(event.target)
      articleID = target.closest(".newscard").attr("id")
      type = target.attr("type")
      $.ajax
        type: "PATCH"
        url: "/articles/#{articleID}/newsworthiness"
        data:
          type: type
        success: (data) =>
          $countElement = target.siblings(".news-vote-count")
          currentCount = parseInt($countElement.text())
          count = @calculateCount(type, data.previous_type, currentCount)
          $countElement.text(count)
        error: ->
          console.log('Error')

  calculateCount: (type, previousType, currentCount) ->
    if type == previousType
      if type == 'increment'
        currentCount -= 1
      else
        currentCount += 1
    else
      scale = if previousType then 2 else 1
      if type == 'increment'
        currentCount += scale
      else
        currentCount -= scale

  toggleBookmark: ->
    $("#article-list").on "click", ".bookmark", (event) =>
      $.ajax
        type: "POST"
        url: "/articles/#{@articleID(event)}/bookmark"
        success: (data) ->
          button = $(event.currentTarget)
          if data.active
            button.addClass("label-info")
            button.removeClass("btn-default")
          else
            button.removeClass("label-info")
            button.addClass("btn-default")

  showComments: ->
    $("#article-list").on "click", ".show-comments", (event) =>
      $("[data-article-id='#{@articleID(event)}']").show()
      $button = $(event.target)
      $button.hide()
      $button.siblings(".hide-comments").show()

  hideComments: ->
    $("#article-list").on "click", ".hide-comments", (event) =>
      $(".news-comments[data-article-id='#{@articleID(event)}']").hide()
      $button = $(event.target)
      $button.hide()
      $button.siblings(".show-comments").show()

  incrementReadCount: ->
    $("#article-list").on "click", ".read-article", (event) =>
      $.ajax
        type: "PATCH"
        url: "/api/articles/#{@articleID(event)}/increment_read_count"
        error: ->
          console.log('Something went horribly wrong while incrementing read count')
