json.id user_medication.id
json.dosage user_medication.dosage
json.user user_medication.user
json.provider user_medication.provider
json.medication do
  json.partial! user_medication.medication, partial: 'medications/medication', as: :medication 
end