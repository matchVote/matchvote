class CommentPresenter < SimpleDelegator
  def comment
    @comment ||= __getobj__
  end

  def user
    @user ||= CitizenPresenter.new(comment.user)
  end

  def reply_level_class(level)
    level.to_i.zero? ? "" : "reply#{level}"
  end

  def created_at_date
    comment.created_at.strftime("%m/%d/%y")
  end

  def created_at_time
    comment.created_at.strftime("%l:%M%p")
  end

  def has_no_replies?
    comment.comments.size.zero?
  end

  def displayed?(reply)
    reply == 0 ? "" : "display:none"
  end

  def reply_ids
    comment.comments.map(&:id)
  end

  def liked?(user)
    UserCommentChange.exists?(comment_id: id, user_id: user.id) if user
  end

  def username
    user.username
  end

  def user_profile_pic_url
    user.profile_pic_url
  end

  def user_location
    state = user.address.state
    state.blank? ? nil : "from #{state}"
  end
end
