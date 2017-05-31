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
      $.ajax
        type: "PATCH"
        url: "/articles/#{articleID}/newsworthiness"
        data:
          type: target.attr("type")
        success: (data) =>
          target.siblings(".news-vote-count").text(data.count)
