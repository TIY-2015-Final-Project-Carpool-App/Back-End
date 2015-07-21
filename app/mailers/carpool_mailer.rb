class CarpoolMailer < ApplicationMailer
  default from: "no-reply@convoythingyapp.com"
  layout 'mailer'

  def join_email(join)
    @user = user
    mail(to: @user.email, subject: 'Registration Email')
  end
end
