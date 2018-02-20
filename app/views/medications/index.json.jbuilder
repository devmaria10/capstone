json.array! @medications.each do |medication|
  json.name medication.name
end
