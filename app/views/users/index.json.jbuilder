json.array! @users do |user|
	json.id user.id
	json.username user.username
	json.first_name user.first_name
	json.last_name user.last_name
	json.address user.address
	json.phone_number user.phone_number
	json.email user.email
	json.avatar user.avatar
  json.latitude user.latitude
  json.longitude user.longitude
end