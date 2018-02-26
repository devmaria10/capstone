json.array! @diagnoses.each do |diagnosis|
  json.id diagnosis.id
  json.name diagnosis.name
  json.icd_10_code diagnosis.icd_10_code
end
