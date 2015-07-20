class RegistrationEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    UserMailer.registration_email(user).deliver_now
  end
end
