class Rider < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :ridable, polymorphic: true

  after_validation :distance

  def distance
    user = self.ridable
    user_coordinates = Geocoder.coordinates(user.address)
    origin = self.appointment.origin
    origin_coordinates = Geocoder.coordinates(origin)
    destination = self.appointment.destination
    destination_coordinates = Geocoder.coordinates(destination)
    distance_from_origin = Geocoder::Calculations.distance_between(user_coordinates, origin_coordinates)
    distance_from_destination = Geocoder::Calculations.distance_between(user_coordinates, destination_coordinates)
    binding.pry
    
    self.distance_from_destination = distance_from_destination
    self.distance_from_origin = distance_from_origin
  end
end
