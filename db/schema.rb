# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160430184115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_details", ["order_id", "product_id"], name: "index_order_details_on_order_id_and_product_id", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "channel_id"
    t.float    "price_in_dollars"
    t.datetime "placement_date"
    t.integer  "legacy_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "orders", ["legacy_id"], name: "index_orders_on_legacy_id", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "legacy_id"
    t.jsonb    "skus",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "products", ["legacy_id"], name: "index_products_on_legacy_id", unique: true, using: :btree

end
