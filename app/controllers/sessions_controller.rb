class SessionsController < ApplicationController

  def new
  end

  def show
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).recent.per(10)
  end

  def show_comments
    user = current_user
    @comments = user.comments.page(params[:page]).recent.per(10)
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).recent.per(10)
    render :show_comments
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, flash: {success: "ログインしました。"}
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, flash: {success: "ログアウトしました。"}
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end