require 'rails_helper'

RSpec.describe AddressChecker do
  describe '.call' do
    context 'when the address is an IPv4' do
      it 'returns :ipv4 for a valid IPv4 address' do
        ipv4_address = Faker::Internet.ip_v4_address
        expect(described_class.call(ipv4_address)).to eq(:ipv4)
      end

      it 'returns :invalid_address for an invalid IPv4 address' do
        invalid_ipv4_address = '999.999.999.999'
        expect(described_class.call(invalid_ipv4_address)).to eq(:invalid_address)
      end
    end

    context 'when the address is an IPv6' do
      it 'returns :ipv6 for a valid IPv6 address' do
        ipv6_address = Faker::Internet.ip_v6_address
        expect(described_class.call(ipv6_address)).to eq(:ipv6)
      end

      it 'returns :invalid_address for an invalid IPv6 address' do
        invalid_ipv6_address = '2001::85a3::8a2e:0370:7334'
        expect(described_class.call(invalid_ipv6_address)).to eq(:invalid_address)
      end
    end

    context 'when the address is a URL' do
      it 'returns :url for a valid URL with http' do
        url = Faker::Internet.url
        expect(described_class.call(url)).to eq(:url)
      end

      it 'returns :url for a valid URL without http' do
        url = Faker::Internet.domain_name
        expect(described_class.call(url)).to eq(:url)
      end

      it 'returns :invalid_address for an invalid URL' do
        invalid_url = 'http://'
        expect(described_class.call(invalid_url)).to eq(:invalid_address)
      end
    end

    context 'when the address is invalid' do
      it 'returns :invalid_address for a random string' do
        random_string = 'invalid_url'
        expect(described_class.call(random_string)).to eq(:invalid_address)
      end

      it 'returns :invalid_address for an empty string' do
        empty_string = ''
        expect(described_class.call(empty_string)).to eq(:invalid_address)
      end
    end
  end
end
