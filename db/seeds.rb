# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ['Action', 'Comedy', 'Drama', 'Horror'].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
Geolocation.create!([
  {
    identifier: '192.168.0.1',
    identifier_type: 'ip',
    country: 'United States',
    region: 'California',
    city: 'Los Angeles',
    latitude: 34.052235,
    longitude: -118.243683
  },
  {
    identifier: 'example.com',
    identifier_type: 'url',
    country: 'United States',
    region: 'New York',
    city: 'New York',
    latitude: 40.712776,
    longitude: -74.005974
  },
  {
    identifier: '172.16.254.1',
    identifier_type: 'ip',
    country: 'Canada',
    region: 'Ontario',
    city: 'Toronto',
    latitude: 43.651070,
    longitude: -79.347015
  },
  {
    identifier: 'mywebsite.org',
    identifier_type: 'url',
    country: 'United Kingdom',
    region: 'England',
    city: 'London',
    latitude: 51.507351,
    longitude: -0.127758
  },
  {
    identifier: '10.0.0.1',
    identifier_type: 'ip',
    country: 'Australia',
    region: 'New South Wales',
    city: 'Sydney',
    latitude: -33.868820,
    longitude: 151.209290
  }
])
