json.id @user.id
json.first_name @user.first_name
json.last_name @user.last_name
json.dob @user.dob 
json.street_address @user.street_address
json.city @user.city 
json.state @user.state
json.zip @user.zip 
json.phone_number @user.phone_number 
json.email @user.email

json.diagnosis @user.diagnosis
json.providers @user.providers
json.user_medications do
  json.array! @user.user_medications, partial: 'user_medications/user_medication', as: :user_medication
end

json.timers @user.medication_timers