require 'timeout'
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
    # failure_payload = {
    #   'info' => 'Invalid API key',
    #   'code' => 401
    # }.to_json

    # # Simulate a failed response
    # res = OpenStruct.new(code: '401', body: failure_payload)
    res = retrieve_geolocation_data
    parsed_body = parse_json(res.body)
    if res.code == '200'
      create_geolocation(parsed_body)
    else
      "error : #{parsed_body['info']} code: #{parsed_body['code']}"
    end
  end

  def parse_json(data)
    JSON.parse(data)
  end

  private

  def retrieve_geolocation_data
    GeolocationProvider::Ipstack.make_request(ip_address, HttpProvider::Factory.provider(:net_http))
  end

  def ip_address
    address_type == :url ? UrlToIpConverter.call(address) : address
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
