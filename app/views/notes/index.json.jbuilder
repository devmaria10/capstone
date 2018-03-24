json.array! @notes.each do |note|
  json.id note.id 
  json.date note.date
  json.note note.text
end