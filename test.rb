client = GooglePlaces::Client.new ("AIzaSyDy1b5ruTTBKO9kBVwvdK-kilOYFB9XHdM")
client.spots(34.7055051, 135.4983028).each do |spot|
  puts spot.name
end
