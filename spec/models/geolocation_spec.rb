require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  # describe 'Validations' do
  #   it { is_expected.to validate_presence_of(:identifier) }
  #   it { is_expected.to validate_presence_of(:country) }
  #   it { is_expected.to validate_presence_of(:region) }
  #   it { is_expected.to validate_presence_of(:city) }
  #   it { is_expected.to validate_presence_of(:longitude) }
  #   it { is_expected.to validate_presence_of(:latitude) }
  # end

  describe 'validations' do
    subject(:geolocation) { build(:geolocation) }

    it 'is valid with valid attributes' do
      expect(geolocation).to be_valid
    end

    it 'is not valid without an identifier' do
      geolocation.identifier = nil
      expect(geolocation).to_not be_valid
    end

    it 'is not valid with a duplicate identifier' do
      create(:geolocation, identifier: '192.168.1.1')
      geolocation.identifier = '192.168.1.1'
      expect(geolocation).to_not be_valid
    end

    it 'is not valid with an invalid IP format' do
      geolocation.identifier = 'invalid_ip'
      expect(geolocation).to_not be_valid
    end

    it 'is not valid without a country' do
      geolocation.country = nil
      expect(geolocation).to_not be_valid
    end

    it 'is not valid without a region' do
      geolocation.region = nil
      expect(geolocation).to_not be_valid
    end

    it 'is not valid without a city' do
      geolocation.city = nil
      expect(geolocation).to_not be_valid
    end

    it 'is not valid without a latitude' do
      geolocation.latitude = nil
      expect(geolocation).to_not be_valid
    end

    it 'is not valid with a latitude less than -90' do
      geolocation.latitude = -91
      expect(geolocation).to_not be_valid
    end

    it 'is not valid with a latitude greater than 90' do
      geolocation.latitude = 91
      expect(geolocation).to_not be_valid
    end

    it 'is not valid without a longitude' do
      geolocation.longitude = nil
      expect(geolocation).to_not be_valid
    end

    it 'is not valid with a longitude less than -180' do
      geolocation.longitude = -181
      expect(geolocation).to_not be_valid
    end

    it 'is not valid with a longitude greater than 180' do
      geolocation.longitude = 181
      expect(geolocation).to_not be_valid
    end
  end

  describe 'enum' do
    it 'allows ip as an identifier_type' do
      geolocation = build(:geolocation, identifier_type: 'ip')
      expect(geolocation).to be_valid
    end

    it 'allows url as an identifier_type' do
      geolocation = build(:geolocation, identifier_type: 'url')
      expect(geolocation).to be_valid
    end

    it 'does not allow an invalid identifier_type' do
      geolocation = build(:geolocation, identifier_type: 'invalid_url')
      expect(geolocation).to_not be_valid
    end
  end
end
