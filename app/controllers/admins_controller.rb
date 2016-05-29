class AdminsController < ActionController::Base
  layout 'admin/application'
  before_action :require_admin

  def current_user
    @current_user ||= User.find_by(token: session[:current_user_id])
  end

  private

  def require_admin
    redirect_to root_path unless current_user.admin == true
  end
end
