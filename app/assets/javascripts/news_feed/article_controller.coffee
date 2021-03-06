$(document).on "page:change", =>
  return unless $("#article-list").length
  new @ArticleController('#article-list')

class @ArticleController
  @signInAlert: ->
    sweetAlert {
      title: 'Not signed in'
      text: 'You must sign in or create an account to do that.'
      type: 'warning'
      confirmButtonText: 'Login or Create Account'
      showCancelButton: true
      cancelButtonText: 'Cancel'
    }, () => window.location.href = '/citizens/sign_in'

  constructor: (@root) ->
    @bindEvents()
    @voteLocked = false

  bindEvents: ->
    @newsworthinessIncrease()
    @newsworthinessDecrease()
    @toggleBookmark()
    @showComments()
    @hideComments()
    @pulsePoll()
    @shareArticle()

  articleID: (event) ->
    $(event.target).closest(".newscard").attr("id")

  newsworthinessIncrease: ->
    $(@root).on "click", ".newsworthiness-increase", (event) =>
      if !@voteLocked
        @voteLocked = true
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
    $(@root).on "click", ".newsworthiness-decrease", (event) =>
      if !@voteLocked
        @voteLocked = true
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
        @voteLocked = false
      error: (xhr) =>
        if xhr.status = 401
          ArticleController.signInAlert()
          @voteLocked = false
        else
          console.log('Err', xhr)

  calculateCount: (type, currentCount) ->
    if type is 'increase'
      currentCount += 1
    else
      currentCount -= 1

  toggleBookmark: ->
    $(@root).on "click", ".bookmark", (event) =>
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
            ArticleController.signInAlert()
          else
            console.log('Err', xhr)

  showComments: ->
    $(@root).on "click", ".show-comments", (event) =>
      $("[data-article-id='#{@articleID(event)}']").show()
      $button = $(event.target)
      $button.hide()
      $button.siblings(".hide-comments").show()

  hideComments: ->
    $(@root).on "click", ".hide-comments", (event) =>
      $(".news-comments[data-article-id='#{@articleID(event)}']").hide()
      $button = $(event.target)
      $button.hide()
      $button.siblings(".show-comments").show()

  pulsePoll: ->
    $(@root).on "click", ".poll-response", (event) =>
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
            ArticleController.signInAlert()
          else
            console.log('Failed to create poll')

  shareArticle: ->
    $(@root).on "click", ".share-article", (event) =>
      $(event.target).fadeOut =>
        $("[data-share-article='#{@articleID(event)}']").fadeIn()
