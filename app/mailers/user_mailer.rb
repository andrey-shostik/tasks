class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail to: @user.email
  end

  def social_logged(user)
    @user = user
    mail to: @user.email
  end
end
