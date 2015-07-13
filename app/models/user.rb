class User < ActiveRecord::Base
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
	validates :username, presence: true, uniqueness: true
	validates :first_name, :last_name, presence: true 
	validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX,
  														            message: "provided is not a valid email." }

  before_validation :ensure_access_token

  has_many :children
  has_many :contacts, as: :contactable
  has_many :joined_carpools
  has_many :carpools, through: :joined_carpools
  has_many :created_carpools, class_name: "Carpool", foreign_key: :creator_id

  def ensure_access_token
  	if self.access_token.blank?
  		self.access_token = User.generate_token
  	end
  end

  def self.generate_token
  	token = SecureRandom.hex
  	while User.exists?(access_token: token)
  		token = SecureRandom.hex
  	end
  	token
  end

  def regenerate_token!
  	self.access_token = nil
  	self.save
  end
end
