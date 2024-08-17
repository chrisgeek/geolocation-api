module GeolocationProvider
  class Ipstack

    def self.make_request(address, http_request_caller)
      url = "http://api.ipstack.com/#{address}?access_key=2e83972042157d24001b621e3998439d&fields=#{Geolocation.field_types}"
      http_request_caller.call(url)
    end
  end
end
