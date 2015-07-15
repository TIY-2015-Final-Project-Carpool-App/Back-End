class Child < ActiveRecord::Base
  validates :first_name, :last_name, presence: true

  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  has_one :medical
  has_many :contacts, as: :contactable
end
