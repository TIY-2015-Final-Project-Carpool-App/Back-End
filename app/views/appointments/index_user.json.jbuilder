json.array! riders do |rider|
  json.partial! 'appointment2', appointment: rider.appointment
end
