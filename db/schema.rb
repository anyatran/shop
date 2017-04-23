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

ActiveRecord::Schema.define(version: 20170423004646) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.decimal  "unit_price",  precision: 12, scale: 2
    t.decimal  "total_price", precision: 12, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.boolean  "purchased"
    t.decimal  "subtotal",   precision: 12, scale: 2
    t.decimal  "tax",        precision: 12, scale: 2
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "final_cost", precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.decimal  "price",                           precision: 8, scale: 2, null: false
    t.string   "title",               limit: 255,                         null: false
    t.integer  "available_inventory",                                     null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "purchased_items", force: :cascade do |t|
    t.integer  "history_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "total_cost", precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["history_id"], name: "index_purchased_items_on_history_id"
    t.index ["product_id"], name: "index_purchased_items_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
