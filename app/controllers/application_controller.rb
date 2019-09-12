class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
  before_action :set_search

  def set_search
    @q = Post.all.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).recent
  end

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end