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
        url: "/comments/#{id}/likes"
        success: (count) =>
          $button = $(event.delegateTarget)
          count = parseInt($button.text()) + 1
          $button.html(count + @glyphiconHeart)
        error: -> console.log("No likey!")
