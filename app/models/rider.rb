class Rider < ActiveRecord::Base
  validates :rider_role, presence: true
  validates_numericality_of :distance_from_origin, less_than_or_equal_to: :filter
  validates :ridable_id, uniqueness: { scope: [:appointment_id, :ridable_type], 
              message: "cannot join a single appointment more than once." }

  belongs_to :appointment
  belongs_to :ridable, polymorphic: true

  before_validation :distance

  def distance
    user_coordinates = Geocoder.coordinates(self.ridable.address)
    origin_coordinates = Geocoder.coordinates(self.appointment.origin)
    destination_coordinates = Geocoder.coordinates(self.appointment.destination)
    self.distance_from_origin = Geocoder::Calculations.distance_between(user_coordinates, origin_coordinates)
    self.distance_from_destination = Geocoder::Calculations.distance_between(user_coordinates, destination_coordinates)
  end

  def filter
    self.appointment.distance_filter
  end

end
