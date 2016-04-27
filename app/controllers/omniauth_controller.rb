class OmniauthController < ApplicationController
  skip_before_action :require_user
  before_action :current_user_resorces

  def create
    if @user
      @account.update(user: @user)
      UserMailer.social_logged(@user).deliver_now
      session[:current_user_id] = @user.token
      redirect_to root_path
    else
      @user = @account.create_user(auth_params)
      @profile = @user.create_profile(profile_params)
      UserMailer.registration_confirmation(@user).deliver_now
      session[:current_user_id] = @user.token
      redirect_to edit_user_path(@user)
    end
  end

  def current_user_resorces
    @account = Account.find_or_create_by(uid: auth_hash[:uid],
                                         provider: auth_hash[:provider],
                                         email: auth_hash[:info][:email])
    @user = User.find_by(email: auth_hash[:info][:email])
  end

  private

  def auth_params
    password = "#{rand(100)}_sample_password_#{rand(100)}"
    {
      token: auth_hash[:credentials][:token],
      email: auth_hash[:info][:email],
      password: password,
      password_confirmation: password
    }
  end

  def profile_params
    {
      first_name: auth_hash[:info][:first_name],
      last_name: auth_hash[:info][:last_name]
    }
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
