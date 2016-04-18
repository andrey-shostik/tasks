class OmniauthController < ApplicationController
  skip_before_action :require_user
  before_action :current_user_resorces

  def create
    if @user
      @account[user: @user]
    else
      @user = User.create(auth_params)
      @account[user_id: @user]
    end
    binding.pry
    @account.save
    session[:current_user_id] = @user.token
    redirect_to root_path
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
      first_name: auth_hash[:extra][:raw_info][:first_name],
      last_name: auth_hash[:extra][:raw_info][:last_name],
      token: auth_hash[:credentials][:token],
      email: auth_hash[:info][:email],
      password: password,
      password_confirmation: password
    }
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
