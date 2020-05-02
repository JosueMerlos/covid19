# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_30_020923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "english_name"
    t.string "spanish_name"
    t.string "iso3", limit: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "covid_informations", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.integer "active_cases"
    t.integer "deaths"
    t.integer "recovered"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_covid_informations_on_country_id"
  end

  create_table "daily_informations", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.integer "new_cases"
    t.integer "new_deaths"
    t.date "date_event"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_daily_informations_on_country_id"
  end

  add_foreign_key "covid_informations", "countries"
  add_foreign_key "daily_informations", "countries"
end
