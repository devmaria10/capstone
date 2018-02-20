json.array! @providers.each do |provider|
  json.name provider.name
  json.address provider.address
end

