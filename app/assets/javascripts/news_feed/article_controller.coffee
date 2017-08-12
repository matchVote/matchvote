$(document).on "page:change", ->
  return unless $("#article-list").length
  new ArticleController()

class ArticleController
  constructor: ->
    @isPaginating = false
    @bindEvents()

  bindEvents: ->
    @newsworthinessChange()
    @toggleBookmark()
    @showComments()
    @hideComments()
    @scrollingPagination()

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
        success: (data) ->
          count = parseInt(target.siblings(".news-vote-count").text())
          count = if type == "increment" then count + 1 else count - 1
          target.siblings(".news-vote-count").text(count)
        error: ->
          sweetAlert "", "You can only vote once per article"

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

  scrollingPagination: ->
    $(window).scroll =>
      url = $(".pagination .next_page").attr("href")
      if url and @isHalfwayThroughList() and not @isPaginating
        @isPaginating = true
        $(".spinner").show()
        $.getScript url, =>
          @isPaginating = false
          $(".spinner").hide()

  isEndOfList: ->
    $(window).scrollTop() is $(document).height() - $(window).height()

  isHalfwayThroughList: ->
    $(window).scrollTop() > $(document).height() / 2
