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

ActiveRecord::Schema.define(version: 20150829130822) do

  create_table "active_requests", force: :cascade do |t|
    t.string   "donor_id"
    t.string   "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "superadmin",             default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "facebook_users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "facebookusers", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_nationalid"
    t.string   "patient_name"
    t.string   "blood_type"
    t.date     "expiredate"
    t.integer  "bloodbag"
    t.string   "hospital_name"
    t.string   "hospital_location"
    t.date     "created_at",            default: '2015-08-23', null: false
    t.datetime "updated_at",                                   null: false
    t.float    "hospital_location_lat"
    t.float    "hospital_location_lng"
    t.integer  "num_of_donors"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.date     "created_at",             default: '2015-08-23', null: false
    t.datetime "updated_at",                                    null: false
    t.string   "name"
    t.string   "phone"
    t.string   "nationalid"
    t.string   "blood_type"
    t.string   "gender"
    t.date     "lastdonation"
    t.integer  "savedpeople",            default: 0
    t.float    "location_lat"
    t.float    "location_lng"
    t.string   "location_name"
    t.integer  "num_of_active_requests"
    t.boolean  "pause",                  default: false
    t.date     "birth_date"
    t.integer  "notifications",          default: 0
    t.boolean  "can_donate",             default: true
    t.boolean  "hide_account",           default: false
    t.boolean  "stop_getting_email",     default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
