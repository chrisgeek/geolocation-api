class GeolocationSerializer
  include Alba::Resource
  attributes :id, :ip, :ip_type, :continent_code, :continent_name, :country_code, :country_name, :region_code,
             :region_name, :city, :zip, :latitude, :longitude, :created_at, :updated_at
end
