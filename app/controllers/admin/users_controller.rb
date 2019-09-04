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

  def update
    @user = User.find(params[:id])
    if @user.update(user_update_params)
      redirect_to root_path, notice: 'ユーザー情報の編集が完了しました'
    else
      flash[:alert] = '編集の保存に失敗しました'
      render :edit
    end
  end

  def destroy
    #@がなくてもよさそう
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

  def user_update_params
    params.require(:user).permit(:email, :password)
  end
  
  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end