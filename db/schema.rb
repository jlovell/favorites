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

ActiveRecord::Schema.define(version: 20160409213139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address_1"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "addresses", ["restaurant_id"], name: "index_addresses_on_restaurant_id", using: :btree

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "dishes", ["category_type", "category_id"], name: "index_dishes_on_category_type_and_category_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["dish_id"], name: "index_ratings_on_dish_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_provider"
    t.string   "auth_uid"
    t.string   "name"
  end

  add_index "users", ["auth_provider", "auth_uid"], name: "index_users_on_auth_provider_and_auth_uid", unique: true, using: :btree
  add_index "users", ["auth_provider"], name: "index_users_on_auth_provider", using: :btree
  add_index "users", ["auth_uid"], name: "index_users_on_auth_uid", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "restaurants"
  add_foreign_key "ratings", "dishes"
  add_foreign_key "ratings", "users"
end
