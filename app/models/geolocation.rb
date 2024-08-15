require 'resolv'
class Geolocation < ApplicationRecord
  validates :identifier, presence: true, uniqueness: true#, format: { with: Resolv::AddressRegex }
  validates :country, presence: true
  validates :region, presence: true
  validates :city, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  enum :identifier_type, { ip: 'ip', url: 'url' }, validate: true
end
