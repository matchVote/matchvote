$(document).on "page:change", ->
  return unless $("#article-list").length
  new Article()

class Article
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @newsworthinessChange()
    @bookmarkToggle()

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

  bookmarkToggle: ->
    $(".bookmark").on "click", (event) =>
      articleID = $(event.target).closest(".newscard").attr("id")
      $.ajax
        type: "POST"
        url: "/articles/#{articleID}/bookmark"
        success: (data) ->
          button = $(event.delegateTarget)
          if data.active
            button.addClass("label-info")
          else
            button.removeClass("label-info")

