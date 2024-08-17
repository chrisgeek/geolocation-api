require 'rails_helper'

RSpec.describe 'Geolocations', type: :request do
  describe 'GET /show' do
    let(:ip) { Faker::Internet.ip_v4_address }
    before{ create(:geolocation, ip: ip) }

    it 'returns http success' do
      get '/api/v1/geolocation/', params: { geolocation: { ip: ip } }
      expect(response).to have_http_status(:success)
    end
  end
end
