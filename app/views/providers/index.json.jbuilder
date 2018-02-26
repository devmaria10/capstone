json.array! @providers.each do |provider|
  json.id provider.id
  json.name provider.name
  json.address provider.address
end

