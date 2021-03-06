class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index_for_article]

  def create
    if reply_level < ArticlesController::REPLY_LIMIT
      comment = Comment.create!(
        text: params[:text],
        user: current_user,
        commentable_type: params[:type],
        commentable_id: params[:id])

      render partial: "articles/comments/comment",
        locals: { comment: CommentPresenter.new(comment),
                  reply_level: reply_level,
                  reply_limit: ArticlesController::REPLY_LIMIT }
    else
      head :forbidden
    end
  end

  def index_for_article
    comments = retrieve_comments(params)
      .take(ArticlesController::COMMENT_LIMIT)
      .map { |c| CommentPresenter.new(c) }

    render partial: "articles/comments/index", locals: {
      comments: comments,
      reply_limit: ArticlesController::REPLY_LIMIT
    }
  end

  def likes
    if user_can_like?(params[:id])
      Comment.increment_counter(:likes, params[:id])
      create_change(params[:id], "like")
      render text: "liked"
    else
      Comment.decrement_counter(:likes, params[:id])
      remove_change(params[:id])
      render text: "unliked"
    end
  end

  private

  def reply_level
    @reply_level ||= params[:reply_level].to_i
  end

  def retrieve_comments(params)
    if params[:order] == "reply_count"
      Comment.find_by_sql(reply_count_ordered_sql(params[:id], params[:type]))
    else
      Comment.where(
        commentable_id: params[:id],
        commentable_type: params[:type]
      ).order(params[:order] => :desc)
    end
  end

  def user_can_like?(id)
    not UserCommentChange.exists?(comment_id: id, user_id: current_user.id)
  end

  def create_change(id, type)
    UserCommentChange.create(
      comment_id: id,
      user_id: current_user.id,
      change_type: type)
  end

  def remove_change(id)
    UserCommentChange.where(comment_id: id, user_id: current_user.id).destroy_all
  end

  def reply_count_ordered_sql(id, type)
    <<-SQL
      SELECT C.*
      FROM comments C
      LEFT JOIN (
        SELECT commentable_id, commentable_type, count(*) reply_count
        FROM comments
        GROUP BY commentable_id, commentable_type
        HAVING commentable_type = 'Comment'
      ) R on C.id = R.commentable_id
      WHERE C.commentable_type = '#{type}'
        AND C.commentable_id = #{id}
      ORDER BY R.reply_count DESC NULLS LAST;
    SQL
  end
end
