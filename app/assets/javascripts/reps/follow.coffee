$(document).on "page:change", ->
  $followButtonContainer = $(".follow-button-container")
  new Rep.Follow($followButtonContainer) if $followButtonContainer.length

class Rep.Follow
  constructor: (@$followButtonContainer) ->
    @followRep()
    @unfollowRep()

  followRep: ->
    @$followButtonContainer.on "click", '.follow-button', (event) =>
      $.ajax
        type: "POST",
        url: "/api/relationships",
        data:
          relationship:
            followed_id: $(event.target).data("followedId")
        success: (unfollowButtonHtml) =>
          @$followButtonContainer.html(unfollowButtonHtml)
          sweetAlert '', 'You are now following this official.'

  unfollowRep: ->
    @$followButtonContainer.on "click", '.unfollow-button', (event) =>
      $.ajax
        type: "POST",
        url: "/api/relationships/unfollow",
        data:
          relationship:
            followed_id: $(event.target).data("followedId")
        success: (followButtonHtml) =>
          @$followButtonContainer.html(followButtonHtml)
          sweetAlert '', 'You are no longer following this official.'
