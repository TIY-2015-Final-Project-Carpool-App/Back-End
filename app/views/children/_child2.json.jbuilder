json.id child.id
json.first_name child.first_name
json.last_name child.last_name
json.age child.age
json.dob child.dob
json.address child.address
json.phone_number child.phone_number
json.height child.height
json.weight child.weight
json.latitude child.latitude
json.longitude child.longitude

json.parent do
  json.partial! 'users/user', user: child.user
end

json.medical do
  if child.medical
    json.id child.medical.id
    json.child_id child.medical.child_id
    json.conditions child.medical.conditions
    json.medications child.medical.medications
    json.notes child.medical.notes
    json.allergies child.medical.allergies
    json.insurance child.medical.insurance
    json.religious_preference child.medical.religious_preference
    json.blood_type child.medical.blood_type
  else
    json.null!
  end
end

json.contacts do
  if !child.contacts.empty?
    json.array! child.contacts do |contact| 
      json.partial! 'contacts/contact', contact: contact
    end
  else  
    json.null!
  end
end
