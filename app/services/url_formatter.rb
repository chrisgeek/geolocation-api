# frozen_string_literal: true

require 'uri'

class UrlFormatter
  def self.extract_host(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") unless uri.scheme
    uri.host.downcase
  end
end
