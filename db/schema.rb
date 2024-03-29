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

ActiveRecord::Schema.define(version: 20140901021854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "email",                      default: "",      null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "timezone"
    t.string   "preferred_digest_frequency", default: "daily"
    t.integer  "preferred_digest_hour",      default: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true, using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree

  create_table "alerts", force: true do |t|
    t.integer  "account_id",              null: false
    t.string   "subreddit",               null: false
    t.string   "keywords",   default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["account_id"], name: "index_alerts_on_account_id", using: :btree
  add_index "alerts", ["subreddit", "account_id"], name: "index_alerts_on_subreddit_and_account_id", using: :btree

  create_table "digests", force: true do |t|
    t.integer  "account_id",              null: false
    t.string   "subreddits", default: [],              array: true
    t.string   "keywords",   default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "digests", ["account_id"], name: "index_digests_on_account_id", using: :btree

end
