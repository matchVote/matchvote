$(document).on "page:change", ->
  return unless $("#article-list").length
  new ArticleController()

class ArticleController
  constructor: ->
    @bindEvents()
    @rootAnchor = '#article-list'
    @sign_in_path = '/citizens/sign_in'

  bindEvents: ->
    @newsworthinessIncrease()
    @newsworthinessDecrease()
    @toggleBookmark()
    @showComments()
    @hideComments()
    @incrementReadCount()
    @pulsePoll()
    @shareArticle()

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
      error: (xhr) =>
        if xhr.status == 401
          @sign_in_alert()

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
        error: (xhr) =>
          if xhr.status == 401
            @sign_in_alert()

  showComments: ->
    $("#article-list").on "click", ".show-comments", (event) =>
      if $('.glyphicon-log-in').length
        @sign_in_alert()
        return
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
    $("#article-list").on "click", ".poll-response", (event) =>
      $poll = $(event.target).parents(".news-pulse-poll")
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
        error: (xhr) =>
          if xhr.status == 401
            @sign_in_alert()
          else
            console.log('Failed to create poll')

  shareArticle: ->
    $("#article-list").on "click", ".share-article", (event) =>
      @sign_in_alert()

  sign_in_alert: ->
    sweetAlert {
      title: 'Not signed in',
      text: 'You must sign in or create an account to do that.',
      type: 'warning',
      confirmButtonText: 'Login or Create Account',
      showCancelButton: true,
      cancelButtonText: 'Cancel',
    }, () => window.location.href = @sign_in_path
