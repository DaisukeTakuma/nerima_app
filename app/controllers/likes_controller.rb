class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unless @post.like?(current_user)
      @post.like(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
    end
  end
  
  def destroy
    @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      @post.unlike(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
    end
  end
end


