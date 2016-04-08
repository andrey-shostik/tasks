class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_user

  def current_user
    @current_user ||= User.find_by(token: session[:current_user_id])
  end

  def require_user
    redirect_to welcome_path unless current_user
  end

  helper_method :current_user
end
