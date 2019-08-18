class ApplicationController < ActionController::Base
  #skip_before_filter :verify_authenticity_token
  helper_method :current_user
  before_action :login_required
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def login_required
    redirect_to login_url unless current_user
  end
end

#protect_from_forgery with: :exceptionを追記したら下記が発生
#ActionController::InvalidAuthenticityToken (ActionController::InvalidAuthenticityToken)
#Started DELETE "/logout" for ::1 at 2019-08-18 22:11:48 +0900
#Processing by SessionsController#destroy as HTML
#Can't verify CSRF token authenticity.
#Completed 422 Unprocessable Entity in 1ms (ActiveRecord: 0.0ms)

# 次にskip_before_filter :verify_authenticity_tokenをここに入れると下記のエラーが出現する
#routing error
#Couldn't find Admin::UsersHelper, expected it to be defined in helpers/admin/users_helper.rb
