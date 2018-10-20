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

ActiveRecord::Schema.define(version: 2018_10_20_193316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.string "website"
    t.string "facebook"
    t.index ["country_id"], name: "index_brands_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_allergens", force: :cascade do |t|
    t.bigint "product_id"
    t.boolean "gluten"
    t.boolean "lactose"
    t.boolean "nut"
    t.boolean "ogm"
    t.boolean "soy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_allergens_on_product_id"
  end

  create_table "product_diets", force: :cascade do |t|
    t.bigint "product_id"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.boolean "ketogenic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_diets_on_product_id"
  end

  create_table "product_prices", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "currency_id"
    t.decimal "per_serving_minimum_order"
    t.decimal "per_serving_bulk_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_product_prices_on_currency_id"
    t.index ["product_id"], name: "index_product_prices_on_product_id"
  end

  create_table "product_reviews", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "score"
    t.string "description"
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_reviews_on_product_id"
  end

  create_table "product_shipments", force: :cascade do |t|
    t.bigint "product_id"
    t.boolean "rest_of_world"
    t.boolean "united_states"
    t.boolean "canada"
    t.boolean "europe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_shipments_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name"
    t.string "slug"
    t.float "kcal_per_serving"
    t.float "protein_per_serving"
    t.float "carbs_per_serving"
    t.float "fat_per_serving"
    t.boolean "subscription_available"
    t.boolean "discount_for_subscription"
    t.integer "state", default: 0
    t.string "notes"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flavor", default: 0
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

end
