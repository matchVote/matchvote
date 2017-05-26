$(document).on "page:change", ->
  return unless $("#article-list").length
  new Article()

class Article
  constructor: ->
    @bindEvents()

  bindEvents: ->
    @newsworthinessChange()

  newsworthinessChange: ->
    $("#upvote").on "click", (event) =>
      articleID = $("#article-id").val()
      console.log('ArticleID', articleID)
      # $.ajax
      #   type: "PATCH"
      #   url: "/articles/#{articleID}"
