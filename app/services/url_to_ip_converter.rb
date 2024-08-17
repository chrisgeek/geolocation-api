require 'uri'

class UrlToIpConverter
  def self.extract_domain(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") unless uri.scheme
    uri.host.downcase
    # Remove "www." if it exists
    # domain = domain.sub(/^www\./, '')
  end
end
