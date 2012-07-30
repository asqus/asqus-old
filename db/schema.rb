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

ActiveRecord::Schema.define(:version => 20120724022403) do

  create_table "groups", :force => true do |t|
    t.string   "title"
    t.integer  "members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_option_sets", :force => true do |t|
    t.string   "options_type", :null => false
    t.text     "options",      :null => false
    t.integer  "num_options",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", :force => true do |t|
    t.string   "title"
    t.text     "prompt"
    t.string   "category"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "poll_option_set_id"
    t.integer  "recipient_id"
  end

  create_table "reps", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "state_id"
    t.string   "district"
    t.string   "chamber"
    t.string   "level"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "ansi_code"
    t.string   "statens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "zipcode"
    t.string   "password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "status"
    t.string   "gender"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "poll_option_set_index", :null => false
    t.integer  "poll_id"
    t.integer  "voter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["poll_id", "voter_id"], :name => "index_votes_on_poll_id_and_voter_id", :unique => true

end
