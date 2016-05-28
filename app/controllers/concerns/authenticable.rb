module Authenticable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :current_admin
    before_action :require_user
  end

  def current_user
    @current_user ||= User.find_by(token: session[:current_user_id])
  end

  def current_admin
    @current_user.try(:admin)
  end

  def require_user
    redirect_to dashboard_path unless current_user
  end
end
