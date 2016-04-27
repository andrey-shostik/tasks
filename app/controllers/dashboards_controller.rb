class DashboardsController < ApplicationController
  skip_before_action :require_user

  def show
    @users = User.all
  end
end
