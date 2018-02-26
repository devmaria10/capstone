json.array! @timers.each do |timer|
  json.id timer.id 
  json.last_rang timer.last_rang
  json.increment timer.increment
  json.timerable_id user.timerable_id
  json.timerable_type user.timerable_type 
end
