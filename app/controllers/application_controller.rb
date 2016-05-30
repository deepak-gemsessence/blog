class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_user_log_in

  def current_user

    @current_user ||= User.find_by_id(session[:current_user_id])
  end

  def logged_in?
    !!current_user
  end

  protected

  def check_user_log_in
    redirect_to welcome_index_path unless session[:current_user_id].present?
  end

end
