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

puts 'Seeding User Data...'

User.create!(email: 'user@example.com', password: 'password123')

puts 'Seeding Geolocation Data...'
Geolocation.create!([
  {
    ip: '134.201.250.155',
    ip_type: 'ipv4',
    continent_code: 'NA',
    continent_name: 'North America',
    country_name: 'United States',
    country_code: 'US',
    region_code: 'CA',
    region_name: 'California',
    city: 'Los Angeles',
    zip: '90001',
    latitude: 34.05223400000000,
    longitude: -118.24368500000000
  },
  {
    ip: '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
    ip_type: 'ipv6',
    continent_code: 'AS',
    continent_name: 'Asia',
    country_name: 'Japan',
    country_code: 'JP',
    region_code: '13',
    region_name: 'Tokyo',
    city: 'Tokyo',
    zip: '100-0001',
    latitude: 35.68948750000000,
    longitude: 139.69170640000000
  },
  {
    ip: '192.0.2.1',
    ip_type: 'ipv4',
    continent_code: 'EU',
    continent_name: 'Europe',
    country_name: 'Germany',
    country_code: 'DE',
    region_code: 'BE',
    region_name: 'Berlin',
    city: 'Berlin',
    zip: '10115',
    latitude: 52.52000659999999,
    longitude: 13.40495400000000
  },
  {
    ip: '2607:f0d0:1002:51::4',
    ip_type: 'ipv6',
    continent_code: 'OC',
    continent_name: 'Oceania',
    country_name: 'Australia',
    country_code: 'AU',
    region_code: 'NSW',
    region_name: 'New South Wales',
    city: 'Sydney',
    zip: '2000',
    latitude: -33.86882000000000,
    longitude: 151.20929000000000
  },
  {
    ip: '192.0.2.123',
    ip_type: 'ipv4',
    continent_code: 'SA',
    continent_name: 'South America',
    country_name: 'Brazil',
    country_code: 'BR',
    region_code: 'SP',
    region_name: 'São Paulo',
    city: 'São Paulo',
    zip: '01000-000',
    latitude: -23.55052000000000,
    longitude: -46.63330800000000
  }
])
