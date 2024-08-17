require 'resolv'

class AddressChecker
  URL_REGEX = /\A((http|https|ftp):\/\/)?([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/[^\s]*)?\z/

  attr_reader :address

  def self.call(address)
    new(address).address_type
  end

  def initialize(address)
    @address = address
  end

  def address_type
    return :ipv4 if valid_ipv4?
    return :ipv6 if valid_ipv6?
    return :url if valid_url?

    :invalid_address
  end

  private

  def valid_ipv4?
    address.match? Resolv::IPv4::Regex
  end

  def valid_ipv6?
    address.match? Resolv::IPv6::Regex
  end

  def valid_url?
    address.match? URL_REGEX
  end
end
