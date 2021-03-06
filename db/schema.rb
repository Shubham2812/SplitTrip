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

ActiveRecord::Schema.define(version: 20170604132052) do

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "pin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debts", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "debitor_id"
    t.integer  "creditor_id"
    t.float    "amount"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "debts", ["transaction_id"], name: "index_debts_on_transaction_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "no_of_members"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "people", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "name"
    t.string   "gender"
    t.date     "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "photo"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "group_id"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "transactions", ["group_id"], name: "index_transactions_on_group_id"

  create_table "users", force: :cascade do |t|
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
