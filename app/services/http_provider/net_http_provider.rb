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

      #       case res
      #       when Net::HTTPSuccess
      #         res.body
      #       else
      #         raise "HTTP Request failed with code: #{res.code}, message: #{res.message}"
      #         # ErrorHandler.error_response(res)
      #       end
      # rescue SocketError => e
      #   ErrorHandler.connection_error(e)
      # rescue Timeout::Error => e
      #   ErrorHandler.timeout_error(e)
      # rescue ErrorHandler::UnexpectedError => e
      #   ErrorHandler.unexpected_error(e)
    end

    private

    def setup
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')
      http
    end
  end
end
