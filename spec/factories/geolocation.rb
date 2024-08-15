FactoryBot.define do
  factory :geolocation do
    identifier { "192.168.1.#{rand(1..255)}" }
    identifier_type { 'ip' }
    country { 'United States' }
    region { 'California' }
    city { 'San Francisco' }
    latitude { rand(-90.0..90.0) }
    longitude { rand(-180.0..180.0) }
  end
end
