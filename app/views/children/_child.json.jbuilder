json.id @child.id
json.first_name @child.first_name
json.last_name @child.last_name
json.age @child.age
json.dob @child.dob
json.address @child.address
json.phone_number @child.phone_number
json.height @child.height
json.weight @child.weight
json.latitude @child.latitude
json.longitude @child.longitude
json.parent do
  json.partial! 'users/user', user: @child.user
end