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

ActiveRecord::Schema.define(version: 20180108082442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crypto_currencies", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_crypto_currencies_on_symbol", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "folio_crypto_currencies", force: :cascade do |t|
    t.bigint "folio_id"
    t.bigint "crypto_currency_id"
    t.decimal "holding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_currency_id"], name: "index_folio_crypto_currencies_on_crypto_currency_id"
    t.index ["folio_id"], name: "index_folio_crypto_currencies_on_folio_id"
  end

  create_table "folios", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_folios_on_currency_id"
    t.index ["user_id"], name: "index_folios_on_user_id"
  end

  create_table "market_exchanges", force: :cascade do |t|
    t.bigint "crypto_currency_id"
    t.bigint "currency_id"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_currency_id"], name: "index_market_exchanges_on_crypto_currency_id"
    t.index ["currency_id"], name: "index_market_exchanges_on_currency_id"
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
