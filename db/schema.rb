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

ActiveRecord::Schema.define(version: 20150310191317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", primary_key: "admin_id", force: :cascade do |t|
    t.string "uname",           limit: 255
    t.string "password_digest", limit: 255
    t.string "email",           limit: 255
  end

  create_table "art_images", primary_key: "art_id", force: :cascade do |t|
    t.integer "image_id", default: "nextval('art_images_image_id_seq'::regclass)", null: false
  end

  create_table "arts", primary_key: "art_id", force: :cascade do |t|
    t.string  "art_name", limit: 255
    t.integer "shop_id",                        default: "nextval('arts_shop_id_seq'::regclass)", null: false
    t.money   "price",                scale: 2,                                                   null: false
    t.string  "art_desc", limit: 255
    t.string  "insp",     limit: 30
    t.string  "category", limit: 255
  end

  create_table "bought_art", primary_key: "buyer_id", force: :cascade do |t|
    t.integer "art_id", default: "nextval('bought_art_art_id_seq'::regclass)", null: false
  end

  create_table "comment_art", primary_key: "comment_id", force: :cascade do |t|
    t.integer  "user_id",    default: "nextval('comment_art_user_id_seq'::regclass)", null: false
    t.integer  "art_id",     default: "nextval('comment_art_art_id_seq'::regclass)",  null: false
    t.text     "content"
    t.datetime "time_stamp"
  end

  create_table "rate_art", primary_key: "user_id", force: :cascade do |t|
    t.integer "art_id", default: "nextval('rate_art_art_id_seq'::regclass)", null: false
    t.integer "value",  default: 0
  end

  create_table "report_art", primary_key: "art_id", force: :cascade do |t|
    t.integer "user_id",                 default: "nextval('report_art_user_id_seq'::regclass)", null: false
    t.string  "report_type", limit: 255
  end

  create_table "report_user", primary_key: "accused_id", force: :cascade do |t|
    t.integer "user_id",                 default: "nextval('report_user_user_id_seq'::regclass)", null: false
    t.string  "report_type", limit: 255
  end

  create_table "shops", primary_key: "shop_id", force: :cascade do |t|
    t.string "shop_name", limit: 50
    t.string "shop_desc", limit: 255
    t.string "cover"
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string  "fname",             limit: 255
    t.string  "lname",             limit: 255
    t.string  "uname",             limit: 255
    t.string  "password_digest",   limit: 255
    t.string  "remember_digest"
    t.integer "phone"
    t.string  "email",             limit: 255
    t.string  "address"
    t.integer "reports",                       default: 0
    t.string  "activation_digest"
    t.boolean "activated"
  end

  add_foreign_key "art_images", "arts", primary_key: "art_id", name: "art_images_art_id_fkey", on_update: :cascade, on_delete: :cascade
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
