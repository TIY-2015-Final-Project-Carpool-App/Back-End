class Child < ActiveRecord::Base
  validates :first_name, :last_name, :address, presence: true

  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  has_one :medical
  has_many :contacts, as: :contactable
  has_many :riders, as: :ridable
  has_many :appointments, through: :riders
end
