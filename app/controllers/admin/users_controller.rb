class Admin::UsersController < ApplicationController
#before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @q = Post.where(user_id: params[:id]).ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).recent

    unless @current_user.blank? then
      @logged_in = true
    else
      @logged_in = false
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
  
  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end