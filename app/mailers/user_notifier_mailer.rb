class UserNotifierMailer < ApplicationMailer
  default :from => 'dogood2211@gmail.com'

  def send_completed_deed_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'You did some good; way to go!')
  end
end
