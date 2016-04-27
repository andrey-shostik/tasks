class Api::SessionsController < ApplicationController
  skip_before_action :require_user
  before_action :check_token

  def create
    if User.find_by(token: @token)
      @user = User.find_by(email: params[:user][:email])
      binding.pry
      if @user && @user.authenticate(params[:user][:password])
        session[:current_user_id] = @user.token
        render json: @user
      else
        render text: 'Invlid email or password'
      end
    else
      render text: 'not specified token'
    end
  end

  def destroy
    if User.find_by(token: @token)
      session[:current_user_id] = nil
      render text: 'session has been deleted'
    else
      render text: 'not specified token'
    end
  end

  private

  def check_token
    @token = request.headers['HTTP_TOKEN']
  end
end
