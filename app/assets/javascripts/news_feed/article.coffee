$(document).on "page:change", ->
  return unless $("#article-list").length
  new Article()

class Article
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @newsworthinessChange()

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
        success: (data) =>
          count = parseInt(target.siblings(".news-vote-count").text())
          count = if type == "increment" then count + 1 else count - 1
          target.siblings(".news-vote-count").text(count)
        error: =>
          sweetAlert "", "You can only vote on an article once"
