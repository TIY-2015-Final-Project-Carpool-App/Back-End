json.appointment_id rider.appointment_id
# json.ridable_id rider.ridable_id
json.rider do
  if rider.ridable.is_a? Child
    json.partial! 'children/child2', child: rider.ridable
  else
    json.partial! 'users/user', user: rider.ridable
  end
end
json.ridable_type rider.ridable_type
json.distance_from_origin rider.distance_from_origin
json.distance_from_destination rider.distance_from_destination
json.rider_role rider.rider_role