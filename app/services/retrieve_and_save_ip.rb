class RetrieveAndSaveIp
  attr_reader :address, :address_type, :http_provider

  def self.call(address, address_type, http_provider)
    new(address, address_type, http_provider).send_request
  end

  def initialize(address, address_type, http_provider)
    @address = address
    @address_type = address_type
    @http_provider = http_provider
  end

  def send_request
    res = retrieve_geolocation_data

    case res
    when http_provider.success
      create_geolocation(parse_json(res.body))
    when http_provider.server_error
      "error: #{res.message}, code: #{res.code}"
    else
      raise ErrorHandler::UnexpectedError, res
    end
  end

  private

  def parse_json(data)
    JSON.parse(data)
  end

  def retrieve_geolocation_data
    GeolocationProvider::Factory.provider.make_request(address, http_provider)
  end

  def create_geolocation(geolocation_data)
    Geolocation.create!(
      ip: geolocation_data['ip'],
      ip_type: geolocation_data['type'],
      continent_code: geolocation_data['continent_code'],
      continent_name: geolocation_data['continent_name'],
      country_name: geolocation_data['country_name'],
      country_code: geolocation_data['country_code'],
      region_code: geolocation_data['region_code'],
      region_name: geolocation_data['region_name'],
      city: geolocation_data['city'],
      zip: geolocation_data['zip'],
      latitude: geolocation_data['latitude'],
      longitude: geolocation_data['longitude']
    )
  end
end
