# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_17_222624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "geolocations", force: :cascade do |t|
    t.string "ip"
    t.string "ip_type"
    t.string "continent_code"
    t.string "continent_name"
    t.string "country_name"
    t.string "country_code"
    t.string "region_code"
    t.string "region_name"
    t.string "city"
    t.string "zip"
    t.decimal "latitude", precision: 16, scale: 14
    t.decimal "longitude", precision: 17, scale: 14
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip"], name: "index_geolocations_on_ip", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
