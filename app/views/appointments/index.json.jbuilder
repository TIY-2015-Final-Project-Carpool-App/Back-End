json.array! appointments do |appointment|
  json.partial! 'appointment2', appointment: appointment
end
