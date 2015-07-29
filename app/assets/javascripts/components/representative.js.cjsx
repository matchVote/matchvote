@Representative = React.createClass
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
        <div>{@props.rep.overall_match_percent}</div>
      </div>
      <div className="directory_block_btns">
        <a href={"/representative/#{@props.rep.slug}"} className="btn btn-sm btn-default">
          View Profile
        </a>
        <a href={"/representative/#{@props.rep.slug}"} className="btn btn-sm btn-default">
          Follow
        </a>
      </div>
      <div>{ @verifiedAccount() }</div>
    </div>

  verifiedAccount: ->
    if @props.rep.verified == true
      <image className="verified" title="Verified Account">
        http://data.matchvote.com/images/bluecheck.png
      </image>

