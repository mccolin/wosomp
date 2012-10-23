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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121023211133) do

  create_table "olympiads", :force => true do |t|
    t.string   "name",                   :null => false
    t.string   "slug"
    t.datetime "begins_at"
    t.datetime "ends_at"
    t.datetime "planning_begins_at"
    t.datetime "planning_ends_at"
    t.datetime "registration_begins_at"
    t.datetime "registration_ends_at"
    t.integer  "registration_fee"
    t.string   "location_name"
    t.string   "location_address"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.text     "location_info"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "olympiads", ["begins_at", "ends_at"], :name => "index_event_dates"
  add_index "olympiads", ["planning_begins_at", "planning_ends_at"], :name => "index_planning_dates"
  add_index "olympiads", ["registration_begins_at", "registration_ends_at"], :name => "index_registration_dates"
  add_index "olympiads", ["slug"], :name => "index_olympiads_on_slug"

  create_table "slugs", :force => true do |t|
    t.string   "scope"
    t.string   "slug"
    t.integer  "record_id"
    t.datetime "created_at"
  end

  add_index "slugs", ["scope", "record_id", "created_at"], :name => "index_slugs_on_scope_and_record_id_and_created_at"
  add_index "slugs", ["scope", "record_id"], :name => "index_slugs_on_scope_and_record_id"
  add_index "slugs", ["scope", "slug", "created_at"], :name => "index_slugs_on_scope_and_slug_and_created_at"
  add_index "slugs", ["scope", "slug"], :name => "index_slugs_on_scope_and_slug"

  create_table "suggested_dates", :force => true do |t|
    t.integer  "olympiad_id",                  :null => false
    t.datetime "begins_at"
    t.datetime "ends_at"
    t.integer  "score",         :default => 0
    t.string   "location_name"
    t.text     "notes"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "suggested_dates", ["olympiad_id"], :name => "index_suggested_dates_on_olympiad_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.integer  "facebook_id",            :limit => 8
    t.string   "encrypted_password",                  :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birthday"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.text     "bio"
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
