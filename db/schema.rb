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

ActiveRecord::Schema.define(version: 20140122161711) do

  create_table "consignments", force: true do |t|
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.integer  "tape_id"
    t.text     "security_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.integer  "tape_id"
    t.integer  "consignments_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.text     "tla"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", force: true do |t|
    t.integer  "tape_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.text     "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movements", force: true do |t|
    t.integer  "tape_id"
    t.date     "date"
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tapes", force: true do |t|
    t.text     "reference"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
