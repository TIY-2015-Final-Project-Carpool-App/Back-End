json.array! appointments do |appointment|
  json.partial! 'appointment', appointment: appointment
  # Need to add riders
end
