class Api::UsersController < ApplicationController
  skip_before_action :require_user
  before_action :check_token

  def index
    if User.find_by(token: @token)
      @users = User.all
      render json: @users
    else
      render text: 'Not specified token'
    end
  end

  def create
    if User.find_by(token: @token)
      @user = User.new(user_params)
      if @user.save
        session[:current_user_id] = @user.token
        render json: @user
        UserMailer.registration_confirmation(@user).deliver_now
      else
        render text: 'Error create user'
      end
    else
      render text: 'Not specified token'
    end
  end

  def show
    if User.find_by(token: @token)
      @user = User.find(params[:id])
      render json: @user
    else
      render text: 'Not specified token'
    end
  end

  def update
    if User.find_by(token: @token)
      @user.update(user_params)
      if @user.save
        render json: @user
      else
        render text: 'Error update user'
      end
    else
      render text: 'Not specified token'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name,
                                 :login,
                                 :password_confirmation)
  end

  def check_token
    @token = request.headers['HTTP_TOKEN']
  end
end
