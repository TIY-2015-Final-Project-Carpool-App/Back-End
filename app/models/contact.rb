class Contact < ActiveRecord::Base
  validates :first_name, :last_name, :relationship, :phone_number, presence: true

  geocoded_by :address
  after_validation :geocode

  belongs_to :contactable, polymorphic: true
end