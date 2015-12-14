class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?, :is_friend?

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    current_user != nil
  end

  def is_friend?(user_id)
    current_user.friends.where(:to_id => user_id).any?
  end

  def check_login
    redirect_to login_path unless signed_in?
  end
end
