class Admin::UsersController < ApplicationController
  skip_before_action :login_required
  #before_action :require_admin
  def index
    @users = User.all
  end

  def show
    @posts = Post.where(user_id: params[:id])
    #whereはインスタンスが生成されない。そのため、viewでレンダリングされない。変数に入れて使う際は、参照という形で使用する。
    #@user = User.find(params[:id])もしかしたら必要になる？記載したいとが不明。
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

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
  #下記のpassword_confirmationはDBテーブルに存在しない。
  #  private
  #def user_params
  #  params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  #end
  
  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end