class CarpoolMailer < ApplicationMailer
  default from: "no-reply@convoythingyapp.com"
  layout 'mailer'

  def join_email(joined)
    @joined = joined
    @carpool = joined.carpool
    @user = joined.user
    mail(to: @user.email, subject: "You've been invited to a carpool!")
  end
end
