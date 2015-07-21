json.type 'FeatureCollection'
json.features @listings do |listing|
  json.type 'Feature'
  json.geometry do
    json.type 'Point'
    json.coordinates [listing.lng, listing.lat]
  end
  json.properties do
    json.extract! listing, :id, :price, :street, :bedrooms, :bathrooms, :sq_ft
  end
end
