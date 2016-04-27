class ProfilesController < ApplicationController
  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to user_profile_path
    else
      render :new
    end
  end

  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    @profile.update(profile_params)
    if @profile.save
      redirect_to user_profile_path
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :first_name, :last_name)
  end
end
