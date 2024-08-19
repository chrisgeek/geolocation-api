# frozen_string_literal: true

module GeolocationProvider
  class Ipstack
    def self.make_request(address, http_provider)
      api_key = ENV['IP_STACK_KEY']
      url = "http://api.ipstack.com/#{address}?access_key=#{api_key}&fields=#{Geolocation.field_types}"
      http_provider.call(url)
    end
  end
end
