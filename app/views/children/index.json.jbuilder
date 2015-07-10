json.array! @children do |child|
  json.id child.id
  json.first_name child.first_name
  json.last_name child.last_name
  json.age child.age
  json.dob child.dob
  json.address child.address
  json.phone_number child.phone_number
  json.height child.height
  json.weight child.weight
  json.parent do
    json.id child.user.id
    json.username child.user.username
    json.first_name child.user.first_name
    json.last_name child.user.last_name
    json.address child.user.address
    json.phone_number child.user.phone_number
    json.email child.user.email
    json.avatar child.user.avatar
  end
end