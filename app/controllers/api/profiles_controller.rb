class Api::ProfilesController < ApplicationController
  skip_before_action :require_user
  before_action :check_token

  def create
    if User.find_by(token: @token)
      @profile = current_user.build_profile(profile_params)
      if @profile.save
        render json: @profile
      else
        render text: 'Error save profile'
      end
    else
      render text: 'Not specified token'
    end
  end

  def show
    if User.find_by(token: @token)
      @profile = current_user.profile
      render json: @profile
    else
      render text: 'Not specified token'
    end
  end

  def update
    if User.find_by(token: @token)
      @profile = current_user.profile
      @profile.update(profile_params)
      if @profile.save
        render json: @profile
      else
        render text: 'Error update profile'
      end
    else
      render text: 'Not specified token'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :first_name, :last_name)
  end

  def check_token
    @token = request.headers['HTTP_TOKEN']
  end
end
