class User < ActiveRecord::Base

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
	validates :username, presence: true, uniqueness: true
	validates :first_name, :last_name, :address, presence: true 
	validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX,
  														            message: "provided is not a valid email." }

  before_validation :ensure_access_token, :downcase_email, :ensure_activate_token
  geocoded_by :address
  after_validation :geocode

  has_many :children
  has_many :contacts, as: :contactable
  has_many :joined_carpools
  has_many :carpools, through: :joined_carpools
  has_many :created_carpools, class_name: "Carpool", foreign_key: :creator_id
  has_many :created_appointments, class_name: "Appointment", foreign_key: :creator_id
  has_many :riders, as: :ridable
  has_many :appointments, through: :riders
  has_many :posts, dependent: :destroy

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

  def downcase_email
    if self.email
      self.email = self.email.downcase
    end
  end

  def ensure_activate_token
    if self.activate_token.blank?
      self.activate_token = User.generate_activate_token
    end
  end

  def self.generate_activate_token
    token = SecureRandom.hex
    while User.exists?(activate_token: token)
      token = SecureRandom.hex
    end
    token
  end
end
