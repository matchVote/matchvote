$(document).on "page:change", ->
  return unless $("#article-list").length
  new Article()

class Article
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @newsworthinessChange()
    @toggleBookmark()
    @showComments()
    @hideComments()
    @showReplies()
    @hideReplies()

  articleID: (event) ->
    $(event.target).closest(".newscard").attr("id")

  replyIDs: (event) ->
    $(event.target).closest(".comment").data("reply-ids")

  newsworthinessChange: ->
    $(".newsworthiness").on "click", (event) =>
      target = $(event.target)
      articleID = target.closest(".newscard").attr("id")
      type = target.attr("type")
      $.ajax
        type: "PATCH"
        url: "/articles/#{articleID}/newsworthiness"
        data:
          type: type
        success: (data) ->
          count = parseInt(target.siblings(".news-vote-count").text())
          count = if type == "increment" then count + 1 else count - 1
          target.siblings(".news-vote-count").text(count)
        error: ->
          sweetAlert "", "You can only vote once per article"

  toggleBookmark: ->
    $(".bookmark").on "click", (event) =>
      $.ajax
        type: "POST"
        url: "/articles/#{@articleID(event)}/bookmark"
        success: (data) ->
          button = $(event.delegateTarget)
          if data.active
            button.addClass("label-info")
          else
            button.removeClass("label-info")

  showComments: ->
    $(".show-comments").on "click", (event) =>
      $("[data-article-id='#{@articleID(event)}']").show()
      $button = $(event.target)
      $button.hide()
      $button.siblings(".hide-comments").show()

  hideComments: ->
    $(".hide-comments").on "click", (event) =>
      $("[data-article-id='#{@articleID(event)}']").hide()
      $button = $(event.target)
      $button.hide()
      $button.siblings(".show-comments").show()

  showReplies: ->
    $(".show-replies").on "click", (event) =>
      $button = $(event.target)
      $button.hide()
      $button.siblings(".hide-replies").show()
      for id in @replyIDs(event)
        $(".comment[data-id='#{id}']").show()

  hideReplies: ->
    $(".hide-replies").on "click", (event) =>
      $button = $(event.target)
      $button.hide()
      $button.siblings(".show-replies").show()
      for id in @replyIDs(event)
        $(".comment[data-id='#{id}']").hide()
