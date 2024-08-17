require 'rails_helper'

RSpec.describe GeolocationProvider::Factory do
  let(:dummy_class) do
    Class.new do
      def check_ip
        'ip payload'
      end
    end
  end

  describe '.provider' do
    it 'returns the default provider' do
      expect(described_class.provider).to be_an_instance_of(GeolocationProvider::Ipstack)
    end

    it 'returns nil when no provider matches the id' do
      expect(described_class.provider(:non_existent)).to be_nil
    end
  end

  describe '.register' do
    it 'adds a new provider to the list' do
      described_class.register('dummy_class', dummy_class)
      expect(described_class.provider(:dummy_class)).to be_an_instance_of(dummy_class)
    end
  end
end
