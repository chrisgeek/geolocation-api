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

    private

    def setup
      Net::HTTP.new(url.host, url.port)
    end
  end
end
