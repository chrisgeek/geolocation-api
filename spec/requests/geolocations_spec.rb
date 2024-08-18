require 'rails_helper'
require 'feature_helper'

RSpec.describe 'Geolocations', type: :request do
  describe 'GET /show' do
    let(:ip) { Faker::Internet.ip_v4_address }
    let(:invalid_url) { 'invalid_url' }
    let(:headers) { { 'Authorization' => @token, 'content-type' => 'application/json' } }
    let!(:user) { create(:user) }
    let!(:user_params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    before(:each) do
      post '/api/v1/users/login', params: user_params
      @token = JSON.parse(response.body)['token']
    end

    describe ' GET #show' do
      context 'with valid param' do
        before do
          create(:geolocation, ip: ip)

          get '/api/v1/geolocation/', params: { geolocation: { ip: ip } }, headers: headers
        end

        it { expect(response).to have_http_status(:success) }
        it { expect(parsed_response['ip']).to eq(ip) }
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
  end
end
