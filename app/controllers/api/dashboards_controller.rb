class Api::DashboardsController < ApplicationController
  skip_before_action :require_user
  before_action :check_token

  def show
    if User.find_by(token: @token)
      @users = User.all
      render @users
    else
      render text: 'not specified token'
    end
  end

  private

  def check_token
    @token = request.headers['HTTP_TOKEN']
  end
end
