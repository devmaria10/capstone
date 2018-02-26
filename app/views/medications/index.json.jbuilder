json.array! @medications.each do |medication|
  json.id medication.id
  json.name medication.name
end
