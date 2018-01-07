# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180105021528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crypto_currencies", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_crypto_currencies_on_symbol", unique: true
  end

  create_table "folios", force: :cascade do |t|
    t.bigint "user_id"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_folios_on_user_id"
  end

  create_table "market_exchanges", force: :cascade do |t|
    t.string "crypto_currency"
    t.string "fiat_currency"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "role"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
