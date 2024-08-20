require 'rails_helper'

RSpec.describe 'API V1 Routes', type: :routing do
  let(:p) { '/api/v1' }
  let(:geolocations) { 'api/v1/geolocations' }
  let(:users) { 'api/v1/users' }
  let(:auth) { 'api/v1/authentication' }

  describe 'Geolocation routes' do
    it 'routes GET /api/v1/geolocation to api/v1/geolocations#show' do
      expect(get: "#{p}/geolocation").to route_to("#{geolocations}#show")
    end

    it 'routes POST /api/v1/geolocation to api/v1/geolocations#create' do
      expect(post: "#{p}/geolocation").to route_to("#{geolocations}#create")
    end

    it 'routes DELETE /api/v1/geolocation to api/v1/geolocations#destroy' do
      expect(delete: "#{p}/geolocation").to route_to("#{geolocations}#destroy")
    end
  end

  describe 'User routes' do
    it 'routes POST /api/v1/users to api/v1/users#create' do
      expect(post: "#{p}/users").to route_to("#{users}#create")
    end
  end

  describe 'Authentication routes' do
    it 'routes POST /api/v1/users/login to api/v1/authentication#login' do
      expect(post: "#{p}/users/login").to route_to("#{auth}#login")
    end
  end

  describe 'Non-existent routes' do
    it 'does not route GET /api/v1/users' do
      expect(get: '/api/v1/users').not_to be_routable
    end

    it 'does not route PUT /api/v1/geolocation' do
      expect(put: '/api/v1/geolocation').not_to be_routable
    end
  end
end
