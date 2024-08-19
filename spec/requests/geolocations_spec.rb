require 'rails_helper'
require 'feature_helper'
require 'net/http'

RSpec.describe 'Geolocations', type: :request do
  let(:valid_ip) { Faker::Internet.ip_v4_address }
  let(:invalid_url) { 'invalid_url' }
  let(:valid_url) { 'www.example.com' }
  let(:invalid_input) { 'invalid_input' }
  let(:geolocation_data) do
    {
      'ip' => valid_ip,
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
    response = Net::HTTPOK.new('1.1', '200', 'OK')
    allow(response).to receive(:body).and_return(geolocation_data.to_json)
    response
  end

  let(:server_error) do
    Net::HTTPServerError.new('1.1', '500', 'Internal Server Error')
  end

  let(:headers) { { 'Authorization' => @token, 'content-type' => 'application/json' } }
  let!(:user) { create(:user, password: 'password123') }
  let!(:user_params) { { user: { email: user.email, password: 'password123' } } }

  before(:each) do
    post '/api/v1/users/login', params: user_params
    @token = parsed_response['token']
  end

  describe 'GET /api/v1/geolocations' do
    context 'with valid param' do
      before do
        create(:geolocation, ip: valid_ip)

        get '/api/v1/geolocation/', params: { geolocation: { ip: valid_ip } }, headers: headers
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(parsed_response['ip']).to eq(valid_ip) }
    end

    context 'with empty param' do
      before do
        get '/api/v1/geolocation/', params: { geolocation: { ip: '' } }, headers: headers
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(parsed_response['error']).to eq('Invalid Input ') }
    end

    context 'with invalid param' do
      before do
        get '/api/v1/geolocation/', params: { geolocation: { ip: invalid_url } }, headers: headers
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(parsed_response['error']).to eq("Invalid Input #{invalid_url}") }
    end
  end

  describe 'POST /api/v1/geolocations' do
    context 'with a valid IP address' do
      it 'returns a new geolocation hash' do
        allow(GeolocationProvider::Ipstack).to receive(:make_request).and_return(success_response)

        expect { post '/api/v1/geolocation', params: { geolocation: { ip: valid_ip } }.to_json, headers: headers }.to change(Geolocation, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['output']).to be_a(Hash)
      end
    end

    context 'with a valid URL' do
      it 'creates a new geolocation from URL' do
        allow(GeolocationProvider::Ipstack).to receive(:make_request).and_return(success_response)

        expect { post '/api/v1/geolocation', params: { geolocation: { ip: valid_url } }.to_json, headers: headers }.to change(Geolocation, :count).by(1)

        expect(response).to have_http_status(:success)
        expect(parsed_response['output']).to be_a(Hash)
      end
    end

    context 'with an invalid input' do
      it 'returns an error for invalid input' do
        post '/api/v1/geolocation', params: { geolocation: { ip: invalid_input } }.to_json, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include('Invalid Input')
      end
    end

    context 'when the geolocation already exists' do
      before do
        create(:geolocation, ip: valid_ip)
      end

      it 'returns an existing record message' do
        post '/api/v1/geolocation', params: { geolocation: { ip: valid_ip } }.to_json, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['error']).to include('already exists')
      end
    end
  end

  describe 'DELETE /api/v1/geolocation' do
    let(:geolocation_ip) { '56.25.25.26' }

    context 'when the geolocation exists' do
      before do
        create(:geolocation, ip: '56.25.25.26')
        delete '/api/v1/geolocation', params: { geolocation: { ip: geolocation_ip } }.to_json, headers: headers
      end

      it 'deletes the geolocation' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/Geolocation deleted successfully/)
      end

      it 'removes the geolocation from the database' do
        expect(Geolocation.find_by(ip: geolocation_ip)).to be_nil
      end
    end

    context 'when the geolocation does not exist' do
      before do
        delete '/api/v1/geolocation', params: { geolocation: { ip: geolocation_ip } }.to_json, headers: headers
      end

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
