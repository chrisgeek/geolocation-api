require 'resolv'
class Geolocation < ApplicationRecord
  URL_REGEX = /((ftp|http|https):\/\/)?(\w+:?\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@\-\/]))?/
  # FIELD_TYPES = [attribute_names << 'type'] - %w[created_at updated_at id ip_type]

  validates :ip, presence: true, uniqueness: true, format: { with: Resolv::AddressRegex }
  validates :country_name, presence: true
  validates :region_name, presence: true
  validates :city, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  enum :ip_type, { ipv4: 'ipv4', ipv6: 'ipv6' }, validate: true

  def self.field_types
    (['type', *attribute_names] - %w[created_at updated_at id ip_type]).join(',')
  end
end
