json.id joined_carpool.id
json.carpool do
  json.partial! 'carpool', carpool: joined_carpool.carpool
end
json.invited_user do
  json.partial! 'users/user', user: joined_carpool.user
  json.activated joined_carpool.activated
  json.join_token joined_carpool.join_token
end
