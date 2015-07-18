json.id carpool.id
json.creator do
  json.partial! 'users/user', user: carpool.creator
end
json.title carpool.title
json.description carpool.description

