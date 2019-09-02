class RelationshipsController < ApplicationController
  #before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to admin_user_path, notice: 'フォローしました。'
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to admin_user_path, notice: 'フォローを解除しました。'
  end
end
