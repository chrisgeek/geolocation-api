class CreateGeolocations < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :ip
      t.string :ip_type
      t.string :continent_code
      t.string :continent_name
      t.string :country_name
      t.string :country_code
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :zip
      t.decimal :latitude, precision: 16, scale: 14
      t.decimal :longitude, precision: 17, scale: 14

      t.timestamps
    end
    add_index :geolocations, :ip, unique: true
  end
end
