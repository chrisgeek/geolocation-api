# frozen_string_literal: true

require 'uri'

class UrlFormatter
  class << self
    def extract_host(url)
      uri = URI.parse(url)
      uri = URI.parse("http://#{url}") unless uri.scheme
      uri.host.downcase
    end

    def convert_to_ip(url)
      IPSocket.getaddress(url)
    end
  end
end
