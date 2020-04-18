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

ActiveRecord::Schema.define(version: 2020_03_29_032151) do

  create_table "countries", force: :cascade do |t|
    t.string "english_name"
    t.string "spanish_name"
    t.string "iso3", limit: 3
    t.integer "phone_cod", limit: 4
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["iso3"], name: "index_countries_on_iso3", unique: true
    t.index ["phone_cod"], name: "index_countries_on_phone_cod", unique: true
  end

  create_table "covid_informations", force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "new_cases"
    t.integer "new_deaths"
    t.integer "recovered"
    t.date "date_event"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_covid_informations_on_country_id"
  end

  add_foreign_key "covid_informations", "countries"
end
