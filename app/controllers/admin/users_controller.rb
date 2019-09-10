class Admin::UsersController < ApplicationController
#before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @q = Post.where(user_id: params[:id]).ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).recent.per(10)
    @comments = @user.comments.page(params[:page]).recent.per(10)

    unless @current_user.blank? then
      @logged_in = true
    else
      @logged_in = false
    end
  end

  def show_comments
    @user = User.find(params[:id])
    @comments = @user.comments.page(params[:page]).recent.per(10)
    unless @current_user.blank? then
      @logged_in = true
    else
      @logged_in = false
    end
    render :show_comments
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to admin_user_url(user), flash: {success: "ユーザー「#{user.name}」を登録しました。"}
    else
      render :new
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_update_params)
      redirect_to root_path, flash: {success: "ユーザー情報の編集が完了しました。"}
    else
      render :edit, flash: {danger: "編集が失敗しました。"}
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_url, flash: {success: "ユーザー「#{user.name}」を削除しました。ご利用ありがとうございました。"}
  end

  def following
    @title = "がフォローしているユーザー"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "のフォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:email, :password)
  end
  
  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end