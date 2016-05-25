class Admin::UsersController < AdminsController
  before_action :set_user, only: [:destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
