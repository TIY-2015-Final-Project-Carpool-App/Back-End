json.id joined_carpool.id
json.carpool do
  json.partial! 'carpool', carpool: joined_carpool.carpool
end
json.user do
  json.partial! 'users/user', user: joined_carpool.user
end
json.activated joined_carpool.activated
json.join_token joined_carpool.join_token
