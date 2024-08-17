FactoryBot.define do
  factory :geolocation do
    ip { [Faker::Internet.ip_v4_address, Faker::Internet.ip_v6_address, Faker::Internet.url].sample }
    ip_type { Geolocation.ip_types.values.sample }
    continent_name { %w[north_america africa europe].sample }
    continent_code { %w[na af eu].sample }
    country_name { Faker::Address.country }
    country_code { Faker::Address.country_code }
    region_name { %w[Île-de-France africanne] }
    region_code { %w[idf afn] }
    city { Faker::Address.country }
    zip { Faker::Address.zip_code }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
