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

ActiveRecord::Schema.define(:version => 20130318204315) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "offerings", :force => true do |t|
    t.integer  "olympiad_id"
    t.integer  "sport_id"
    t.text     "details"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "olympiad_id"
    t.integer  "team_id"
    t.boolean  "athlete",                      :default => true
    t.boolean  "captain"
    t.string   "uniform_size",   :limit => 3
    t.string   "uniform_number", :limit => 4
    t.string   "uniform_name",   :limit => 12
    t.boolean  "paid",                         :default => false
    t.boolean  "agree_pay",                    :default => false
    t.boolean  "agree_waiver",                 :default => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

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

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "field"
    t.text     "equipment"
    t.text     "rules"
    t.text     "details"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "num_teams",        :default => 2
    t.integer  "num_per_team",     :default => 1
    t.string   "tournament_style", :default => "bracket"
    t.string   "image"
  end

  create_table "teams", :force => true do |t|
    t.integer  "olympiad_id"
    t.string   "name",        :null => false
    t.string   "color1"
    t.string   "color2"
    t.string   "color1_code"
    t.string   "color2_code"
    t.text     "bio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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
    t.boolean  "admin",                               :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
