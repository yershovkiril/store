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

ActiveRecord::Schema.define(version: 20160717075433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "zip"
    t.string   "phone"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["country_id"], name: "index_addresses_on_country_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
  end

  add_index "authors", ["book_id"], name: "index_authors_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",            precision: 8, scale: 2
    t.integer  "in_stock"
    t.text     "full_description"
    t.string   "image"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "author_id"
    t.integer  "category_id"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id", using: :btree
  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.date     "expires_at"
    t.date     "starts_at"
    t.decimal  "discount",   precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.string   "exp_month"
    t.string   "exp_year"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_books", force: :cascade do |t|
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "quantity"
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "order_books", ["book_id"], name: "index_order_books_on_book_id", using: :btree
  add_index "order_books", ["order_id"], name: "index_order_books_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "ref"
    t.decimal  "total",               precision: 8, scale: 2
    t.decimal  "subtotal",            precision: 8, scale: 2
    t.decimal  "shipment_total",      precision: 8, scale: 2
    t.datetime "completed_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.integer  "coupon_id"
    t.integer  "shipment_id"
  end

  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id", using: :btree
  add_index "orders", ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
  add_index "orders", ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
  add_index "orders", ["shipment_id"], name: "index_orders_on_shipment_id", using: :btree
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "text_review"
    t.boolean  "approved",    default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id"
    t.integer  "book_id"
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "shipments", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",       precision: 8, scale: 2
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["billing_address_id"], name: "index_users_on_billing_address_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["shipping_address_id"], name: "index_users_on_shipping_address_id", using: :btree

  add_foreign_key "addresses", "countries"
  add_foreign_key "authors", "books"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "categories"
  add_foreign_key "order_books", "books"
  add_foreign_key "order_books", "orders"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "credit_cards"
  add_foreign_key "orders", "shipments"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
