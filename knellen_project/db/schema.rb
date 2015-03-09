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

ActiveRecord::Schema.define(version: 20150304144911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", primary_key: "admin_id", force: :cascade do |t|
    t.string "uname",           limit: 255, null: false
    t.string "password_digest", limit: 255, null: false
    t.string "email",           limit: 255, null: false
  end

  add_index "admins", ["uname"], name: "admins_uname_key", unique: true, using: :btree

  create_table "arts", primary_key: "art_id", force: :cascade do |t|
    t.string  "art_name", limit: 255,                                                             null: false
    t.integer "shop_id",                        default: "nextval('arts_shop_id_seq'::regclass)", null: false
    t.money   "price",                scale: 2,                                                   null: false
    t.string  "art_desc", limit: 255
    t.string  "insp",     limit: 30
    t.string  "category", limit: 255
  end

  create_table "bought_art", id: false, force: :cascade do |t|
    t.integer "buyer_id", default: "nextval('bought_art_buyer_id_seq'::regclass)", null: false
    t.integer "art_id",   default: "nextval('bought_art_art_id_seq'::regclass)",   null: false
  end

  create_table "comment_art", primary_key: "c_id", force: :cascade do |t|
    t.integer  "user_id",    default: "nextval('comment_art_user_id_seq'::regclass)", null: false
    t.integer  "art_id",     default: "nextval('comment_art_art_id_seq'::regclass)",  null: false
    t.text     "content",                                                             null: false
    t.datetime "time_stamp"
  end

  create_table "rate_art", id: false, force: :cascade do |t|
    t.integer "art_id",  default: "nextval('rate_art_art_id_seq'::regclass)",  null: false
    t.integer "user_id", default: "nextval('rate_art_user_id_seq'::regclass)", null: false
    t.integer "value",   default: 0
  end

  create_table "report_art", id: false, force: :cascade do |t|
    t.integer "art_id",                  default: "nextval('report_art_art_id_seq'::regclass)",  null: false
    t.integer "user_id",                 default: "nextval('report_art_user_id_seq'::regclass)", null: false
    t.string  "report_type", limit: 255
  end

  create_table "report_user", id: false, force: :cascade do |t|
    t.integer "accused_id",              default: "nextval('report_user_accused_id_seq'::regclass)", null: false
    t.integer "user_id",                 default: "nextval('report_user_user_id_seq'::regclass)",    null: false
    t.string  "report_type", limit: 255
  end

  create_table "shops", primary_key: "shop_id", force: :cascade do |t|
    t.string "shop_name", limit: 50,  null: false
    t.string "shop_desc", limit: 255, null: false
  end

  add_index "shops", ["shop_name"], name: "shops_shop_name_key", unique: true, using: :btree

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string  "fname",             limit: 255,                 null: false
    t.string  "lname",             limit: 255,                 null: false
    t.string  "uname",             limit: 255,                 null: false
    t.boolean "active_account",                default: false
    t.string  "password_digest",   limit: 255
    t.string  "remember_digest"
    t.decimal "phone"
    t.string  "email",             limit: 255,                 null: false
    t.string  "address",           limit: 255
    t.integer "strikes",                       default: 0
    t.string  "activation_digest"
    t.boolean "activated"
  end

  add_index "users", ["uname"], name: "users_uname_key", unique: true, using: :btree

  add_foreign_key "arts", "shops", primary_key: "shop_id", name: "arts_shop_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bought_art", "arts", primary_key: "art_id", name: "bought_art_art_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bought_art", "users", column: "buyer_id", primary_key: "user_id", name: "bought_art_buyer_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "comment_art", "arts", primary_key: "art_id", name: "comment_art_art_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "comment_art", "users", primary_key: "user_id", name: "comment_art_user_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "rate_art", "arts", primary_key: "art_id", name: "rate_art_art_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "rate_art", "users", primary_key: "user_id", name: "rate_art_user_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "report_art", "users", column: "art_id", primary_key: "user_id", name: "report_art_art_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "report_art", "users", primary_key: "user_id", name: "report_art_user_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "report_user", "users", column: "accused_id", primary_key: "user_id", name: "report_user_accused_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "report_user", "users", primary_key: "user_id", name: "report_user_user_id_fkey", on_update: :cascade, on_delete: :cascade
end
