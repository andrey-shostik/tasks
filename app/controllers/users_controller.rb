class UsersController < ApplicationController
  skip_before_action :require_user

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      binding.pry
      session[:current_user_id] = @user.token
      redirect_to root_path
      UserMailer.registration_confirmation(@user).deliver_now
    else
      flash[:error] = 'some have invalid'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name,
                                 :login,
                                 :password_confirmation)
  end
end
