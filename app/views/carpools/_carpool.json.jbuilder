json.id carpool.id
json.creator do
  json.partial! 'users/user', user: carpool.creator
end
json.title carpool.title
json.users do
  json.array! User.joins(:joined_carpools).where(joined_carpools: { carpool_id: carpool } ) do |user|
    json.partial! 'users/user', user: user
    json.activated user.joined_carpools.where(carpool_id: carpool.id).first.activated
    json.join_token user.joined_carpools.where(carpool_id: carpool.id).first.join_token
  end
end
