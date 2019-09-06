class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to post_path(comment.post_id), notice: "コメントしました"
    else
      redirect_to root_path, notice: "コメントが失敗しました"
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :comment)
  end
end
