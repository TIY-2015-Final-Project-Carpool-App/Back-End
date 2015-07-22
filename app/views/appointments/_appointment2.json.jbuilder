json.id appointment.id
json.carpool_id appointment.carpool_id
json.creator do
  json.partial! 'users/user.json.jbuilder', user: appointment.creator
end
json.start appointment.start
json.title appointment.title
json.description appointment.description
json.origin appointment.origin
json.origin_latitude appointment.origin_latitude
json.origin_longitude appointment.origin_longitude
json.destination appointment.destination
json.destination_latitude appointment.destination_latitude
json.destination_longitude appointment.destination_longitude
json.distance_filter appointment.distance_filter
json.seats appointment.seats
json.riders do 
  json.array! appointment.riders do |rider| 
    json.partial! 'riders/rider.json.jbuilder', rider: rider
  end
end