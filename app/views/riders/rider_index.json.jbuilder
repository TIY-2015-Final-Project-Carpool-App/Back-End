json.array! riders do |rider|
  json.partial! 'appointments/appointment2', appointment: rider.appointment
  json.partial! 'riders/rider', rider: rider
end