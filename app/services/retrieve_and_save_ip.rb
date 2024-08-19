class RetrieveAndSaveIp
  attr_reader :address, :address_type

  def self.call(address, address_type)
    new(address, address_type).send_request
  end

  def initialize(address, address_type)
    @address = address
    @address_type = address_type
  end

  def send_request
    res = retrieve_geolocation_data

    case res
    when Net::HTTPOK
      create_geolocation(parse_json(res.body))
    when Net::HTTPClientError, Net::HTTPServerError
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
    GeolocationProvider::Ipstack.make_request(address, HttpProvider::Factory.provider(:net_http))
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
