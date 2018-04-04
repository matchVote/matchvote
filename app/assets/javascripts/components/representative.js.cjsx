@Representative = React.createClass
  getInitialState: ->
    following: @props.rep.user_following

  verifiedAccount: ->
    if @props.rep.verified == true
      <image className="verified" title="Verified Account">
        http://data.matchvote.com/images/bluecheck.png
      </image>

  toggleFollowingStatus: ->
    if @state.following
      @unfollowRep()
    else
      @followRep()

  followRep: ->
    @serverRequest(
      '/api/relationships',
      true,
      'You are now following this official.')

  unfollowRep: ->
    @serverRequest(
      '/api/relationships/unfollow',
      false,
      'You are no longer following this official.')

  serverRequest: (url, following, message) ->
    $.ajax
      type: "POST",
      url: url,
      data:
        relationship:
          followed_id: @props.rep.id
      success: =>
        @setState
          following: following
        sweetAlert '', message
      error: ->
        console.log 'serverRequest error'

  followBtnType: ->
    if @state.following then 'btn-danger' else 'btn-default'

  render: ->
    <div id={@props.rep.slug} className="directory_block">
      <div>
        <a href={"/representative/#{@props.rep.slug}"}>
          <image src={@props.rep.profile_image_url} className="directory_pic" title={@props.rep.full_name}></image>
        </a>
      </div>
      <div>
        <h4 className="full_name">{@props.rep.full_name}</h4>
      </div>
      <div>
        { "#{@props.rep.government_role} | #{@props.rep.state}" }
      </div>
      <div className="directory_block_btns">
        <a href={"/representative/#{@props.rep.slug}"} className="btn btn-sm btn-default">
          View Profile
        </a>
        <div className={"btn btn-sm #{@followBtnType()}"} onClick={@toggleFollowingStatus}>
          { if @state.following then 'Unfollow' else 'Follow' }
        </div>
      </div>
      <div>{ @verifiedAccount() }</div>
    </div>
