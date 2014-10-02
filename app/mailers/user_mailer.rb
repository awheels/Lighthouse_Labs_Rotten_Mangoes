class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def delete_user_email(user)
    @user = user
    mail(to: @user.email, subject: "Your profile has been deleted.")
  end
  
end
