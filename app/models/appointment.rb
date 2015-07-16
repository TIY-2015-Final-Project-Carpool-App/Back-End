class Appointment < ActiveRecord::Base
  validates :start, :title, :description, :origin, :destination, presence: true

  belongs_to :carpool
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  has_many :riders, dependent: :destroy

  after_validation :set_coordinates

  def set_coordinates
    origin_coord = Geocoder.coordinates(self.origin)
    destination_coord = Geocoder.coordinates(self.destination)
    self.origin_latitude = origin_coord.first
    self.origin_longitude = origin_coord.last
    self.destination_latitude = destination_coord.first
    self.destination_longitude = destination_coord.last
  end
end
