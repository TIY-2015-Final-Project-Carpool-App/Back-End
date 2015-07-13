class JoinedCarpool < ActiveRecord::Base
  validates :user_id, :carpool_id, presence: true
  validates :user_id, uniqueness: { scope: :carpool_id, 
              message: "cannot join a single carpool more than once." }

  belongs_to :carpool
  belongs_to :user

  before_validation :ensure_join_token

  def ensure_join_token
    if self.join_token.blank?
      self.join_token = JoinedCarpool.generate_token
    end
  end

  def self.generate_token
    token = SecureRandom.hex
    while JoinedCarpool.exists?(join_token: token)
      token = SecureRandom.hex
    end
    token
  end
end
