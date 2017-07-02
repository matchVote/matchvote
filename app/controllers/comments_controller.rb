class CommentsController < ApplicationController
  def create
    comment = Comment.create!(
      text: params[:text],
      user_id: params[:user_id],
      commentable_type: 'Article',
      commentable_id: params[:article_id])
    render partial: "articles/comments/comment",
      locals: { comment: CommentPresenter.new(comment), reply: 0 }
  end

  def index_for_article
    comments = retrieve_comments(params)
      .take(ArticlesController::COMMENT_LIMIT)
      .map { |c| CommentPresenter.new(c) }
    render partial: "articles/comments/index", locals: { comments: comments }
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
          SELECT commentable_id, count(*) reply_count, commentable_type
          FROM comments
          GROUP BY commentable_id, commentable_type
          HAVING commentable_type = 'Comment'
      ) R on C.id = R.commentable_id
      WHERE C.commentable_type = '#{type}' AND C.commentable_id = '#{id}'
      ORDER BY R.reply_count;
    SQL
  end
end
