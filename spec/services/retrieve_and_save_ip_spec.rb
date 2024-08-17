require 'rails_helper'
require 'net/http'

RSpec.describe RetrieveAndSaveIp do
  let(:ip_address) { Faker::Internet.ip_v4_address }
  let(:url) { 'example.com' }
  let(:address_type_ip) { :ip }
  let(:address_type_url) { :url }
  let(:retrieve_and_save_ip) { instance_double(RetrieveAndSaveIp) }

  describe '#call' do
    it 'creates a new instance and calls send_request' do
      expect(RetrieveAndSaveIp).to receive(:new).with(ip_address, address_type_ip).and_return(retrieve_and_save_ip)
      expect(retrieve_and_save_ip).to receive(:send_request)

      RetrieveAndSaveIp.call(ip_address, address_type_ip)
    end
  end

  describe '#send_request' do
    let(:geolocation_data) do
      {
        'ip' => ip_address,
        'type' => 'ipv4',
        'continent_code' => 'NA',
        'continent_name' => 'North America',
        'country_name' => 'United States',
        'country_code' => 'US',
        'region_code' => 'CA',
        'region_name' => 'California',
        'city' => 'Mountain View',
        'zip' => '94043',
        'latitude' => 37.4224,
        'longitude' => -122.0842
      }
    end

    let(:success_response) do
      instance_double(Net::HTTPResponse, code: '200', body: geolocation_data.to_json)
    end

    let(:error_response) do
      instance_double(Net::HTTPResponse, code: '401', body: { 'info' => 'Invalid API key', 'code' => 401 }.to_json)
    end

    before do
      allow(GeolocationProvider::Ipstack).to receive(:make_request).and_return(success_response)
    end

    context 'when the request is successful' do
      it 'creates a new Geolocation record' do
        instance = RetrieveAndSaveIp.new(ip_address, address_type_ip)
        expect { instance.send_request }.to change(Geolocation, :count).by(1)

        geolocation = Geolocation.last
        expect(geolocation.ip).to eq(ip_address)
        expect(geolocation.latitude).to be_within(0.0001).of(37.4224)
        expect(geolocation.longitude).to be_within(0.0001).of(-122.0842)
      end
    end

    context 'when the request fails' do
      before do
        allow(GeolocationProvider::Ipstack).to receive(:make_request).and_return(error_response)
      end

      it 'returns an error message' do
        instance = RetrieveAndSaveIp.new(ip_address, address_type_ip)
        result = instance.send_request

        expect(result).to eq('error : Invalid API key code: 401')
      end
    end

    context 'when the address is a URL' do
      let(:extracted_ip) { '93.184.216.34' }

      before do
        allow(UrlFormatter).to receive(:extract_host).with(url).and_return(extracted_ip)
      end

      it 'extracts the host from the URL' do
        instance = RetrieveAndSaveIp.new(url, address_type_url)
        expect(GeolocationProvider::Ipstack).to receive(:make_request).with(extracted_ip, anything)
        instance.send_request
      end
    end
  end
end
