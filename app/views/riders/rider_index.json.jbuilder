json.array! riders do |rider|
  json.partial! 'rider', rider: rider
end