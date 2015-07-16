json.array! riders do |rider|
  json.partial! 'riders/rider', rider: rider
end