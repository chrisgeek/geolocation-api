module GeolocationProvider
  class Ipstack
    # attr_reader :address, :base_url, :http_request_caller

    def self.make_request(address, http_request_caller)
      # fields = Geolocation.attribute_names - %w[created_at updated_at id]
      url = "http://api.ipstack.com/#{address}?access_key=2e83972042157d24001b621e3998439d&fields=#{Geolocation.field_types}"
      # debugger
      http_request_caller.call(url)
    end
  end
end
