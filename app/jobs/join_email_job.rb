class JoinEmailJob < ActiveJob::Base
  queue_as :default

  def perform(joined)
    CarpoolMailer.join_email(joined).deliver_now
  end
end
