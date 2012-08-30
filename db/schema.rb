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

ActiveRecord::Schema.define(:version => 20120828141723) do

  create_table "bnbs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.string   "address_line_one"
    t.string   "address_line_two"
    t.string   "city"
    t.string   "postal_code"
    t.string   "country"
    t.string   "telephone_number"
    t.string   "website"
    t.string   "contact_person"
    t.string   "twitter_account"
    t.string   "facebook_page"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "bnbs", ["user_id"], :name => "index_bnbs_on_user_id"

  create_table "bookings", :force => true do |t|
    t.integer  "guest_id"
    t.boolean  "active"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "status",     :default => "provisional"
  end

  add_index "bookings", ["guest_id"], :name => "index_bookings_on_guest_id"

  create_table "bookings_rooms", :id => false, :force => true do |t|
    t.integer "booking_id"
    t.integer "room_id"
  end

  add_index "bookings_rooms", ["booking_id"], :name => "index_bookings_rooms_on_booking_id"
  add_index "bookings_rooms", ["room_id"], :name => "index_bookings_rooms_on_room_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "booking_id"
    t.string   "color",      :default => "blue"
  end

  add_index "events", ["booking_id"], :name => "index_events_on_booking_id"

  create_table "guests", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "contact_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "line_items", :force => true do |t|
    t.string   "description"
    t.integer  "value"
    t.integer  "booking_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "description"
    t.string   "image"
    t.integer  "order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "bnb_id"
  end

  add_index "photos", ["bnb_id"], :name => "index_photos_on_bnb_id"

  create_table "rooms", :force => true do |t|
    t.string   "description"
    t.boolean  "en_suite"
    t.decimal  "rates"
    t.string   "extras"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "bnb_id"
    t.integer  "room_number"
    t.boolean  "available",   :default => true
    t.integer  "capacity",    :default => 2
  end

  add_index "rooms", ["bnb_id"], :name => "index_rooms_on_bnb_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
