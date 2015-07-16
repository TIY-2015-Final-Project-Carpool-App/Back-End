json.array! joined_carpools do |joined_carpool|
  json.partial! 'joined', joined_carpool: joined_carpool
end