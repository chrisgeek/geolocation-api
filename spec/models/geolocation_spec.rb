require 'rails_helper'

RSpec.describe Geolocation do
  describe 'validations' do
    it { should validate_presence_of(:ip) }
    it { should validate_uniqueness_of(:ip) }
    it { should allow_value('192.168.0.1').for(:ip) }
    it { should_not allow_value('invalid_ip').for(:ip) }

    it { should validate_presence_of(:country_name) }
    it { should validate_presence_of(:country_code) }
    it { should validate_presence_of(:continent_code) }
    it { should validate_presence_of(:continent_name) }
    it { should validate_presence_of(:region_name) }
    it { should validate_presence_of(:region_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:zip) }

    it { should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90).is_less_than_or_equal_to(90) }
    it { should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
  end

  describe 'enums' do
    it { should define_enum_for(:ip_type).with_values(ipv4: 'ipv4', ipv6: 'ipv6').backed_by_column_of_type(:string) }
  end
end
