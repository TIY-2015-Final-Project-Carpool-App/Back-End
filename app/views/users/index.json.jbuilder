json.array! @users do |user|
	json.id user.id
	json.username user.username
	json.full_name user.first_name
	json.last_name user.last_name
	json.address user.address
	json.phone_number user.phone_number
	json.email user.email
	json.avatar user.avatar
end