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

ActiveRecord::Schema.define(version: 20170221135945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "financials", force: :cascade do |t|
    t.string   "name"
    t.string   "money"
    t.datetime "day"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_financials_on_user_id", using: :btree
  end

  create_table "time_managers", force: :cascade do |t|
    t.datetime "from"
    t.datetime "to"
    t.string   "name"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_time_managers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "financials", "users"
  add_foreign_key "time_managers", "users"
end
