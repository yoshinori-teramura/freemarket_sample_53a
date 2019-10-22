json.array! @delivery_types do |type|
  json.id type[1]
  json.name type[0]
end