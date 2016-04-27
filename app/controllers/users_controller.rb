class UsersController < ApplicationController
  skip_before_action :require_user
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.token
      redirect_to new_user_profile_path
      UserMailer.registration_confirmation(@user).deliver_now
    else
      flash[:error] = 'some have invalid'
      render :new
    end
  end

  def show
    @items = @user.items
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
      flash[:error] = 'Invalid password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name,
                                 :login,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
