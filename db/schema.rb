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

ActiveRecord::Schema.define(version: 20160826162027) do

  create_table "actions", force: :cascade do |t|
    t.string  "action"
    t.string  "time_in_come"
    t.integer "customer_id"
  end

  add_index "actions", ["customer_id"], name: "index_actions_on_customer_id"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "properties"
    t.datetime "time"
  end

  add_index "ahoy_events", ["name", "time"], name: "index_ahoy_events_on_name_and_time"
  add_index "ahoy_events", ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
  add_index "ahoy_events", ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"

  create_table "campaings", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "admin_id"
    t.string   "campaing_code"
    t.string   "campaing_title"
    t.boolean  "active"
    t.boolean  "restrict_audio_download"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "campaings", ["active"], name: "index_campaings_on_active"
  add_index "campaings", ["admin_id"], name: "index_campaings_on_admin_id"
  add_index "campaings", ["campaing_code"], name: "index_campaings_on_campaing_code"
  add_index "campaings", ["customer_id"], name: "index_campaings_on_customer_id"

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "submname"
    t.string   "route_files"
    t.string   "empresa"
    t.string   "idempresa"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

  create_table "notices", force: :cascade do |t|
    t.string   "content"
    t.integer  "customer_id"
    t.integer  "admin_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "notices", ["admin_id"], name: "index_notices_on_admin_id"
  add_index "notices", ["customer_id"], name: "index_notices_on_customer_id"

  create_table "publications", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "admin_id"
    t.string   "head_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shared_files", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "fileable_id"
    t.string   "fileable_type"
    t.integer  "admin_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "shared_files", ["fileable_id"], name: "index_shared_files_on_fileable_id"
  add_index "shared_files", ["fileable_type"], name: "index_shared_files_on_fileable_type"

  create_table "visits", force: :cascade do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id"
  add_index "visits", ["visit_token"], name: "index_visits_on_visit_token", unique: true

end
