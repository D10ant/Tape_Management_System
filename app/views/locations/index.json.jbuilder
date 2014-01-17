json.array!(@locations) do |location|
  json.extract! location, :id, :location
  json.url location_url(location, format: :json)
end
