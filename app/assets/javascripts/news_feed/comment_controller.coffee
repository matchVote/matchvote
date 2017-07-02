$(document).on "page:change", ->
  return unless $(".comments-list").length
  new CommentController()

class CommentController
  constructor: ->
    @bindEvents()
    @glyphiconHeart = '\n<div class="glyphicon glyphicon-heart" />'
    @userAccountType = null

  bindEvents: ->
    @submitComment()
    @showReplies()
    @hideReplies()
    @likeComment()
    @reportComment()
    @sortComments()

  comment: (event) ->
    $(event.target).closest(".comment")

  articleID: (event) ->
    $(event.target).closest(".newscard").attr("id")

  replyIDs: (event) ->
    @comment(event).data("reply-ids")

  submitComment: ->
    $(".submit-comment").click (event) =>
      $button = $(event.target)
      userID = $button.data("user-id")
      articleID = $button.data("article-id")
      $commentBox = $(".comment-box[data-article-id=#{articleID}]")
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
        $.ajax
          type: "POST"
          url: "/api/comments"
          data:
            text: $commentBox.val()
            article_id: articleID
            user_id: userID
          success: (html) =>
            commentsListSelector = ".comments-list[data-article-id=#{articleID}]"
            $(html).hide().prependTo(commentsListSelector).fadeIn("slow")
            $commentBox.val("")
            $countDivs = $(".comment-count[data-article-id=#{articleID}]")
            count = parseInt($($countDivs[0]).text()) + 1
            $countDivs.each (index, div) ->
              $(div).text(count)
          error: -> console.log("Comment submission error")

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
      articleID = @articleID(event)
      $.ajax
        type: "GET"
        url: "/api/articles/#{articleID}/comments"
        data:
          type: "Article"
          order: $selectBox.val()
        success: (html) ->
          $(".comments-list[data-article-id=#{articleID}]").html(html)

