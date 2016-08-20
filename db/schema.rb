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

ActiveRecord::Schema.define(version: 20160526032822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounting_records", force: true do |t|
    t.string   "detail"
    t.decimal  "debit",      precision: 8, scale: 2
    t.decimal  "credit",     precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id"
    t.integer  "user_id"
  end

  create_table "articles", force: true do |t|
    t.string   "name"
    t.decimal  "price_cost",         precision: 8, scale: 2
    t.decimal  "percentaje",         precision: 8, scale: 2
    t.decimal  "price_total",        precision: 8, scale: 2
    t.decimal  "quantity",           precision: 8, scale: 2
    t.string   "barcode"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
    t.integer  "category_id",                                default: 1
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "allow_negative",                             default: false
    t.decimal  "minimum_stock",      precision: 8, scale: 2
    t.decimal  "quantity_package",   precision: 8, scale: 2
    t.decimal  "iva",                precision: 4, scale: 2
  end

  add_index "articles", ["id"], name: "index_articles_on_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "current_accounts", force: true do |t|
    t.integer  "customer_id"
    t.string   "detail"
    t.decimal  "debit",       precision: 8, scale: 2
    t.decimal  "credit",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "lastname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deadlines", force: true do |t|
    t.date     "due_date"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_id"
  end

  create_table "invoice_stocks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price_total", precision: 8, scale: 2
  end

  create_table "invoices", force: true do |t|
    t.integer  "customer_id"
    t.decimal  "price_total", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.decimal  "subtotal",    precision: 8, scale: 2
    t.decimal  "discount",    precision: 8, scale: 2
  end

  create_table "orders", force: true do |t|
    t.integer  "article_id"
    t.decimal  "quantity"
    t.decimal  "price_unit",  precision: 8, scale: 2
    t.decimal  "price_total", precision: 8, scale: 2
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount",    precision: 8, scale: 2
    t.string   "name"
  end

  add_index "orders", ["id"], name: "index_orders_on_id", using: :btree

  create_table "stocks", force: true do |t|
    t.integer  "article_id"
    t.decimal  "quantity",         precision: 8, scale: 2
    t.decimal  "price_cost",       precision: 8, scale: 2
    t.integer  "invoice_stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_total"
    t.integer  "category_id"
    t.integer  "supplier_id"
  end

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "name"
    t.string   "username"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "invitado"
    t.boolean  "is_deleted",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
