class CommentPresenter < SimpleDelegator
  def comment
    @comment ||= __getobj__
  end

  def reply_level_class(level)
    level.zero? ? "" : "reply#{level}"
  end

  def created_at_date
    comment.created_at.strftime("%m/%d/%y")
  end

  def created_at_time
    comment.created_at.strftime("%l:%M%p")
  end

  def has_replies?
    comment.comments.size > 0
  end

  def displayed?(reply)
    reply == 0 ? "" : "display:none"
  end

  def reply_ids
    comment.comments.map(&:id)
  end
end
