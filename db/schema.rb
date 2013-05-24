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

ActiveRecord::Schema.define(:version => 20130522081015) do

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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "rating"
    t.string   "region"
    t.string   "slug"
    t.boolean  "approved",         :default => false
    t.boolean  "mappable",         :default => false
    t.integer  "photos_count",     :default => 0
  end

  add_index "bnbs", ["slug"], :name => "index_bnbs_on_slug", :unique => true
  add_index "bnbs", ["user_id"], :name => "index_bnbs_on_user_id"

  create_table "bookings", :force => true do |t|
    t.integer   "guest_id"
    t.boolean   "active",     :default => true
    t.timestamp "created_at",                            :null => false
    t.timestamp "updated_at",                            :null => false
    t.string    "status",     :default => "provisional"
    t.integer   "bnb_id"
    t.integer   "user_id"
    t.boolean   "online",     :default => false
    t.integer   "rate_id"
  end

  add_index "bookings", ["bnb_id"], :name => "index_bookings_on_bnb_id"
  add_index "bookings", ["guest_id"], :name => "index_bookings_on_guest_id"
  add_index "bookings", ["user_id"], :name => "index_bookings_on_user_id"

  create_table "bookings_rooms", :id => false, :force => true do |t|
    t.integer "booking_id"
    t.integer "room_id"
  end

  add_index "bookings_rooms", ["booking_id"], :name => "index_bookings_rooms_on_booking_id"
  add_index "bookings_rooms", ["room_id"], :name => "index_bookings_rooms_on_room_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.string    "locked_by"
    t.string    "queue"
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string    "name"
    t.timestamp "start_at"
    t.timestamp "end_at"
    t.timestamp "created_at",                     :null => false
    t.timestamp "updated_at",                     :null => false
    t.integer   "booking_id"
    t.string    "color",      :default => "blue"
  end

  add_index "events", ["booking_id"], :name => "index_events_on_booking_id"

  create_table "guests", :force => true do |t|
    t.string    "name"
    t.string    "surname"
    t.string    "contact_number"
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
    t.integer   "bnb_id"
    t.integer   "user_id"
    t.string    "email"
    t.string    "slug"
  end

  add_index "guests", ["bnb_id"], :name => "index_guests_on_bnb_id"
  add_index "guests", ["slug"], :name => "index_guests_on_slug", :unique => true
  add_index "guests", ["user_id"], :name => "index_guests_on_user_id"

  create_table "line_items", :force => true do |t|
    t.string    "description"
    t.decimal   "value"
    t.integer   "booking_id"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  add_index "line_items", ["booking_id"], :name => "index_line_items_on_booking_id"

  create_table "payment_notifications", :force => true do |t|
    t.text      "params"
    t.integer   "user_id"
    t.string    "status"
    t.string    "transaction_id"
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
  end

  add_index "payment_notifications", ["transaction_id"], :name => "index_payment_notifications_on_transaction_id"
  add_index "payment_notifications", ["user_id"], :name => "index_payment_notifications_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "description"
    t.string   "image"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "bnb_id"
    t.boolean  "main",        :default => false
    t.boolean  "processed",   :default => false
  end

  add_index "photos", ["bnb_id"], :name => "index_photos_on_bnb_id"

  create_table "plans", :force => true do |t|
    t.integer   "duration"
    t.decimal   "price"
    t.boolean   "active"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.string    "name"
    t.boolean   "free"
  end

  create_table "rate_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rates", :force => true do |t|
    t.decimal  "price"
    t.boolean  "active"
    t.string   "description"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string    "description"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string    "description"
    t.boolean   "en_suite"
    t.decimal   "rates"
    t.string    "extras"
    t.timestamp "created_at",                    :null => false
    t.timestamp "updated_at",                    :null => false
    t.integer   "bnb_id"
    t.integer   "room_number"
    t.boolean   "available",   :default => true
    t.integer   "capacity",    :default => 2
  end

  add_index "rooms", ["bnb_id"], :name => "index_rooms_on_bnb_id"

  create_table "searches", :force => true do |t|
    t.string    "country"
    t.string    "region"
    t.string    "city"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string    "paypal_customer_token"
    t.string    "paypal_recurring_profile_token"
    t.integer   "user_id"
    t.timestamp "created_at",                                        :null => false
    t.timestamp "updated_at",                                        :null => false
    t.boolean   "active_profile",                 :default => false
    t.integer   "plan_id"
    t.timestamp "expiry_date"
  end

  add_index "subscriptions", ["plan_id"], :name => "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "suggestions", :force => true do |t|
    t.text      "suggestion"
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.string    "subject"
  end

  add_index "suggestions", ["user_id"], :name => "index_suggestions_on_user_id"

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at",                                :null => false
    t.timestamp "updated_at",                                :null => false
    t.string    "password_digest"
    t.string    "remember_token"
    t.boolean   "admin",                  :default => false
    t.string    "encrypted_password",     :default => "",    :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.integer   "role_id"
    t.string    "country"
    t.string    "contact_number"
    t.string    "surname"
    t.string    "authentication_token"
    t.string    "slug"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
