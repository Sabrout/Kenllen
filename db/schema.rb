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

ActiveRecord::Schema.define(version: 20150417144453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.integer  "cart_id"
    t.integer  "item_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cart_items", ["item_id"], name: "index_cart_items_on_item_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_attachments", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "item_name",   limit: 15,               null: false
    t.string   "description", limit: 200, default: ""
    t.string   "inspiration", limit: 70,  default: ""
    t.decimal  "price",                                null: false
    t.integer  "quantity",                default: 1
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "category"
  end

  add_index "items", ["shop_id"], name: "index_items_on_shop_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "topic"
    t.text     "body"
    t.integer  "received_messageable_id"
    t.string   "received_messageable_type"
    t.integer  "sent_messageable_id"
    t.string   "sent_messageable_type"
    t.boolean  "opened",                     default: false
    t.boolean  "recipient_delete",           default: false
    t.boolean  "sender_delete",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.boolean  "recipient_permanent_delete", default: false
    t.boolean  "sender_permanent_delete",    default: false
  end

  add_index "messages", ["ancestry"], name: "index_messages_on_ancestry", using: :btree
  add_index "messages", ["sent_messageable_id", "received_messageable_id"], name: "acts_as_messageable_ids", using: :btree

  create_table "shops", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "shop_name",  limit: 25, null: false
    t.text     "shop_desc"
    t.string   "cover"
    t.string   "icon"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "shops_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "shop_id"
  end

  add_index "shops_users", ["shop_id", "user_id"], name: "index_shops_users_on_shop_id_and_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.integer  "phone"
    t.string   "email"
    t.string   "address"
    t.string   "image"
    t.integer  "reports",                default: 0
    t.string   "uname",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
