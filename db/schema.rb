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

ActiveRecord::Schema.define(:version => 20101018142911) do

  create_table "calendars", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",      :default => "#3366CC"
  end

  create_table "events", :force => true do |t|
    t.datetime "from"
    t.datetime "to"
    t.string   "title"
    t.string   "place"
    t.text     "description"
    t.boolean  "all_day"
    t.integer  "calendar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recurrence_frequency"
    t.date     "recurrence_until"
    t.integer  "recurrence_interval"
  end

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "twenty_four_hour_format", :default => false
    t.boolean  "day_before_month",        :default => false
    t.integer  "week_start",              :default => 0
    t.string   "time_zone",               :default => "UTC"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "remote_calendars", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "color",             :default => "#3366CC"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "ical_data"
    t.datetime "ical_data_updated"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calendar_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
