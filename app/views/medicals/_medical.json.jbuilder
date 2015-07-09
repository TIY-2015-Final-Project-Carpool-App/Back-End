json.id @medical.id
json.child do
 json.partial! 'children/child' 
end
json.conditions @medical.conditions
json.medications @medical.medications
json.notes @medical.notes
json.allergies @medical.allergies
json.insurance @medical.insurance
json.religious_preference @medical.religious_preference