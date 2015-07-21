require 'csv'

# id,street,status,price,bedrooms,bathrooms,sq_ft,lat,lng
# imports 10^4 rows of data from CSV file

csv_content = File.read('db/listings.csv')
csv = CSV.parse(csv_content, headers: true)

csv.each do |row|
  street = row['street']
  status = row['status']
  price = Integer(row['price'])
  bedrooms = Integer(row['bedrooms'])
  bathrooms = Integer(row['bathrooms'])
  sq_ft = Integer(row['sq_ft'])
  lat = Float(row['lat'])
  lng = Float(row['lng'])

  House.create!(street: street, status: status, price: price,
    bedrooms: bedrooms, bathrooms: bathrooms, sq_ft: sq_ft,
    lat: lat, lng: lng)
end
