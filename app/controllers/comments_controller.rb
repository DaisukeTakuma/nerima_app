class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to post_path(comment.post_id), flash: {success: "コメントしました。"}
    else
      redirect_to root_path, flash: {danger: "コメントに失敗しました。"}
    end
  end

  def destroy
    #未ログインユーザはelse内の処理を実行
    unless current_user.blank? then
      comment = Comment.find(params[:id])
      #ログインユーザがadminか、投稿者なら削除を実行
      if current_user.admin? || current_user.id == comment.user_id
        comment.destroy
        redirect_to post_path(comment.post_id), flash: {success: "削除が完了しました。"}
      else
        redirect_to post_path(comment.post_id), flash: {danger: "削除権限がありません。"}
      end
    else
      redirect_to post_path(comment.post_id), flash: {danger: "削除権限がありません。"}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :comment)
  end
end
