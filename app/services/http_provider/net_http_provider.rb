require 'net/http'
require 'uri'
module HttpProvider
  class NetHttpProvider
    attr_reader :url

    def self.call(base_url)
      new(base_url).make_get_request
    end

    def initialize(base_url)
      @url = URI.parse(base_url)
    end

    def make_get_request
      req = Net::HTTP::Get.new(url)
      setup.request(req)
    end

    def self.success
      Net::HTTPOK
    end

    def self.server_error
      Net::HTTPServerError
    end

    def self.client_error
      Net::HTTPClientError
    end

    private

    def setup
      Net::HTTP.new(url.host, url.port)
    end
  end
end
