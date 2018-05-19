$(document).on "page:change", ->
  return unless $("#article-list").length
  new ArticleController()

class ArticleController
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @newsworthinessIncrease()
    @newsworthinessDecrease()
    @toggleBookmark()
    @showComments()
    @hideComments()
    @incrementReadCount()
    @pulsePoll()


  articleID: (event) ->
    $(event.target).closest(".newscard").attr("id")

  newsworthinessIncrease: ->
    $("#article-list").on "click", ".newsworthiness-increase", (event) =>
      $arrowButton = $(event.target)
      if $arrowButton.hasClass("newsworthiness-disabled")
        return
      selected = $arrowButton.hasClass("newsworthiness-selection")
      action = if selected then "decrease" else "increase"
      articleID = $arrowButton.closest(".newscard").attr("id")
      $oppositeButton = $arrowButton.siblings(".newsworthiness-decrease")
      callback = @newsworthinessSelection(selected, $oppositeButton)
      @newsworthinessRequest(articleID, action, $arrowButton, callback)

  newsworthinessDecrease: ->
    $("#article-list").on "click", ".newsworthiness-decrease", (event) =>
      $arrowButton = $(event.target)
      if $arrowButton.hasClass("newsworthiness-disabled")
        return
      selected = $arrowButton.hasClass("newsworthiness-selection")
      action = if selected then "increase" else "decrease"
      articleID = $arrowButton.closest(".newscard").attr("id")
      $oppositeButton = $arrowButton.siblings(".newsworthiness-increase")
      callback = @newsworthinessSelection(selected, $oppositeButton)
      @newsworthinessRequest(articleID, action, $arrowButton, callback)

  newsworthinessSelection: (selected, $oppositeButton) -> ($arrowButton) ->
    if selected
      $arrowButton.removeClass("newsworthiness-selection")
      $oppositeButton.removeClass("newsworthiness-disabled")
      $oppositeButton.removeClass("nohover")
    else
      $arrowButton.addClass("newsworthiness-selection")
      $oppositeButton.addClass("newsworthiness-disabled")
      $oppositeButton.addClass("nohover")

  newsworthinessRequest: (articleID, action, $arrowButton, callback) ->
    $.ajax
      type: "POST"
      url: "/api/articles/#{articleID}/#{action}_newsworthiness"
      success: (data) =>
        $countElement = $arrowButton.siblings(".news-vote-count")
        currentCount = parseInt($countElement.text())
        count = @calculateCount(action, currentCount)
        $countElement.text(count)
        callback($arrowButton)
      error: ->
        console.log('Newsworthiness update Error')

  calculateCount: (type, currentCount) ->
    if type is 'increase'
      currentCount += 1
    else
      currentCount -= 1

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

  pulsePoll: ->
    $(".news-pulse-poll").on "click", ".poll-response", (event) =>
      $poll = $(event.delegateTarget)
      data = $poll.data()
      data.response = $(event.target).data('response')
      $.ajax
        type: "POST"
        url: "/api/polls"
        data: data
        success: =>
          $button = $(event.target)
          $button.addClass("btn-info")
          $button.addClass("nohover")
          $poll.fadeOut(3000, -> $poll.remove())
        error: ->
          console.log('Failed to create poll')
