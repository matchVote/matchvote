$(document).on "page:change", ->
  return unless $(".comments-list").length
  new CommentController()

class CommentController
  constructor: ->
    @bindEvents()
    @glyphiconHeart = '\n<div class="glyphicon glyphicon-heart" />'

  bindEvents: ->
    @submitComment()
    @showReplies()
    @hideReplies()
    @likeComment()
    @reportComment()
    @sortComments()

  comment: (event) ->
    $(event.target).closest(".comment")

  replyIDs: (event) ->
    @comment(event).data("reply-ids")

  submitComment: ->
    $(".submit-comment").click (event) =>
      $button = $(event.target)
      if $button.data("account-type") == "standard"
        sweetAlert "", "Consider yourself upgraded"
        $button.text('Submit')
      else
        console.log('Comment submitted')

  showReplies: ->
    $(".comments-list").on "click", ".show-replies", (event) =>
      $button = $(event.target)
      $button.hide()
      $button.siblings(".hide-replies").show()
      for id in @replyIDs(event)
        $(".comment[data-id='#{id}']").show()

  hideReplies: ->
    $(".comments-list").on "click", ".hide-replies", (event) =>
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
    $(".comments-list").on "click", ".like-button", (event) =>
      id = @comment(event).data("id")
      $.ajax
        type: "PATCH"
        url: "/api/comments/#{id}/likes"
        success: (status) =>
          $button = $(event.currentTarget)
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
    $(".comments-list").on "click", ".report-comment", (event) =>
      sweetAlert "", "User's comment has been reported."

  sortComments: ->
    $(".sort-comments").change (event) =>
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

