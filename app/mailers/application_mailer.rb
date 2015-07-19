class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@convoythingyapp.com"
  layout 'mailer'

  def registration_email(user)
    @user = user
    mail(to: @user.email, subject: 'Registration Email')
  end
end
