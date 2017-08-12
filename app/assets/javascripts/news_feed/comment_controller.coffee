$(document).on "page:change", ->
  return unless $(".comments-list").length
  new CommentController()

class CommentController
  constructor: ->
    @eventHandlerElement = $("#article-list")
    @bindEvents()
    @glyphiconHeart = '\n<div class="glyphicon glyphicon-heart" />'
    @userAccountType = null

  bindEvents: ->
    @typeComment()
    @submitComment()
    @showRepliesClick()
    @hideRepliesClick()
    @likeComment()
    @reportComment()
    @sortComments()
    @createReplyButtonClick()
    @closeReplyButtonClick()

  comment: (event) ->
    $(event.target).closest(".comment")

  articleID: (event) ->
    $(event.target).closest(".newscard").attr("id")

  replyIDs: (event) ->
    @comment(event).data("reply-ids")

  ctblSelector: (root, id, type) ->
    "#{root}[data-ctbl-id=#{id}][data-ctbl-type=#{type}]"

  typeComment: ->
    @eventHandlerElement.on "keypress", ".comment-box", (event) =>
      $commentBoxError = $(event.target).siblings(".comment-box-error")
      if $commentBoxError.is(":visible")
        $commentBoxError.hide()

  submitComment: ->
    @eventHandlerElement.on "click", ".submit-comment", (event) =>
      $button = $(event.target)
      userID = $button.data("user-id")
      ctblID = $button.data("ctbl-id")
      ctblType = $button.data("ctbl-type")
      $commentBox = $(@ctblSelector(".comment-box", ctblID, ctblType))
      @userAccountType ?= $button.data("account-type")
      if @userAccountType == "standard"
        # This will redirect to a payment page in the future
        $.ajax
          type: "PATCH"
          url: "/api/citizens/#{userID}/upgrade_account"
          success: (data) =>
            sweetAlert "", "Consider yourself upgraded"
            $button.text("Submit")
            $commentBox.attr("placeholder", "Add your comment")
            @userAccountType = data.account_type
          error: -> console.log("Account upgrade error")
      else
        text = $commentBox.val()
        $commentBox.val("")
        if text
          $.ajax
            type: "POST"
            url: "/api/comments"
            data:
              text: text
              id: ctblID
              type: ctblType
              reply_level: parseInt($button.data("reply-level")) + 1
            success: (html) =>
              if ctblType == "Article"
                @addComment(html, ctblID)
              else
                $button = $(".close-reply[data-comment-id=#{ctblID}]")
                @closeReplyBox(ctblID, $button)
                @addReply(html, ctblID)
                @updateDisplayRepliesButton(ctblID)
            error: -> console.log("Comment submission error")
        else
          console.log("Textbox empty")
          $commentBox.siblings(".comment-box-error").show()

  addComment: (html, id) ->
    commentsListSelector = ".comments-list[data-article-id=#{id}]"
    $(html).hide().prependTo(commentsListSelector).fadeIn("slow")
    $countDivs = $(".comment-count[data-article-id=#{id}]")
    count = parseInt($($countDivs[0]).text()) + 1
    $countDivs.each (index, div) ->
      $(div).text(count)

  addReply: (html, parentID) ->
    $comment = $(".comment[data-id=#{parentID}]")
    $reply = $(html)
    $reply.insertAfter($comment).fadeIn("slow")
    replyIDs = $comment.data("reply-ids")
    replyIDs.push($reply.data("id"))
    $comment.attr("data-reply-ids", replyIDs)

  updateDisplayRepliesButton: (id) ->
    $showRepliesButton = $(".show-replies[data-comment-id=#{id}]")
    $hideRepliesButton = $(".hide-replies[data-comment-id=#{id}]")
    if not $showRepliesButton.is(":visible") and not $hideRepliesButton.is(":visible")
      $hideRepliesButton.show()

  showRepliesClick: ->
    @eventHandlerElement.on "click", ".show-replies", (event) =>
      $button = $(event.target)
      $button.hide()
      $button.siblings(".hide-replies").show()
      for id in @replyIDs(event)
        $(".comment[data-id='#{id}']").show()

  hideRepliesClick: ->
    @eventHandlerElement.on "click", ".hide-replies", (event) =>
      $button = $(event.target)
      $button.hide()
      $button.siblings(".show-replies").show()
      @hideReplies(@replyIDs(event))

  hideReplies: (ids) ->
    for id in ids
      $reply = $(".comment[data-id='#{id}']")
      replyIDs = $reply.data("reply-ids")
      if replyIDs.length > 0
        $reply.find(".hide-replies").hide()
        $reply.find(".show-replies").show()
      $reply.hide()
      @hideReplies(replyIDs)

  likeComment: ->
    @eventHandlerElement.on "click", ".like-button", (event) =>
      id = @comment(event).data("id")
      $.ajax
        type: "PATCH"
        url: "/api/comments/#{id}/likes"
        success: (status) =>
          $button = $(event.currentTarget)
          count = parseInt($button.text())
          if status == "liked"
            $button.addClass("label-info")
            $button.removeClass("btn-default")
            count += 1
          else
            $button.removeClass("label-info")
            $button.addClass("btn-default")
            count -= 1
          $button.html(count + @glyphiconHeart)
        error: -> console.log("No likey!")

  reportComment: ->
    @eventHandlerElement.on "click", ".report-comment", (event) =>
      sweetAlert "", "User's comment has been reported."

  sortComments: ->
    @eventHandlerElement.on "change", ".sort-comments", (event) =>
      $selectBox = $(event.target)
      articleID = @articleID(event)
      $.ajax
        type: "GET"
        url: "/api/articles/#{articleID}/comments"
        data:
          type: "Article"
          order: $selectBox.val()
        success: (html) ->
          $(".comments-list[data-article-id=#{articleID}]").html(html)
        error: ->
          console.log("some shit happened with the sort!")

  createReplyButtonClick: ->
    @eventHandlerElement.on "click", ".create-reply", (event) =>
      id = @comment(event).data("id")
      $button = $(event.target).hide()
      $button.siblings(".close-reply").show()
      $(".writereply[data-comment-id=#{id}]").show()

  closeReplyButtonClick: ->
    @eventHandlerElement.on "click", ".close-reply", (event) =>
      id = @comment(event).data("id")
      @closeReplyBox(id, $(event.target))

  closeReplyBox: (commentID, $button) ->
    $button.hide()
    $button.siblings(".create-reply").show()
    $(".writereply[data-comment-id=#{commentID}]").hide()

