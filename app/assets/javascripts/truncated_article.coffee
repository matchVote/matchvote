$(document).on "page:change", ->
  return unless $("#truncated-articles").length
  new TruncatedArticle()

class TruncatedArticle
  constructor: ->
    @root = '#truncated-articles'
    @toggleBookmark()
    @shareArticle()

  articleID: (event) ->
    $(event.target).closest(".whitecard").attr("id")

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
            @sign_in_alert()

  shareArticle: ->
    $(@root).on "click", ".share-article", (event) =>
      $(event.target).fadeOut =>
        $("[data-share-article='#{@articleID(event)}']").fadeIn()
