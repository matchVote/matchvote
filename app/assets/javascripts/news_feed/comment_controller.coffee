$(document).on "page:change", ->
  return unless $(".comments-list").length
  new CommentController()

class CommentController
  constructor: ->
    @bindEvents()
    @glyphiconHeart = '\n<div class="glyphicon glyphicon-heart" />'

  bindEvents: ->
    @showReplies()
    @hideReplies()
    @likeComment()
    @reportComment()
    @sortComments()

  comment: (event) ->
    $(event.target).closest(".comment")

  replyIDs: (event) ->
    @comment(event).data("reply-ids")

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
      @hideNestedReplies(@replyIDs(event))

  hideNestedReplies: (ids) ->
    for id in ids
      $reply = $(".comment[data-id='#{id}']")
      $reply.find(".hide-replies").hide()
      $reply.find(".show-replies").show()
      $reply.hide()
      @hideNestedReplies($reply.data("reply-ids"))

  likeComment: ->
    $(".like-button").on "click", (event) =>
      id = @comment(event).data("id")
      $.ajax
        type: "PATCH"
        url: "/api/comments/#{id}/likes"
        success: (status) =>
          $button = $(event.delegateTarget)
          count = parseInt($button.text())
          if status == "liked"
            $button.addClass("label-info")
            count += 1
          else
            $button.removeClass("label-info")
            count -= 1
          $button.html(count + @glyphiconHeart)
        error: -> console.log("No likey!")

  reportComment: ->
    $(".report-comment").on "click", (event) =>
      sweetAlert "", "User's comment has been reported."

  sortComments: ->
    $(".sort-comments").on "change", (event) =>
      $selectBox = $(event.target)
      articleID = $selectBox.closest(".newscard").attr("id")
      $.ajax
        type: "GET"
        url: "/api/articles/#{articleID}/comments"
        data:
          type: "Article"
          order: $selectBox.val()
        success: (html) ->
          console.log(html)
          $(".comments-list[data-article-id=#{articleID}]").html(html)

