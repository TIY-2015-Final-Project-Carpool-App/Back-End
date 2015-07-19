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

ActiveRecord::Schema.define(version: 20150719214912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "creator_id"
    t.datetime "start"
    t.string   "title"
    t.string   "description"
    t.string   "origin"
    t.float    "origin_latitude"
    t.float    "origin_longitude"
    t.string   "destination"
    t.float    "destination_latitude"
    t.float    "destination_longitude"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "carpool_id"
    t.integer  "distance_filter"
  end

  create_table "carpools", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "children", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.date     "dob"
    t.string   "address"
    t.string   "phone_number"
    t.integer  "height"
    t.integer  "weight"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "relationship"
    t.string   "address"
    t.string   "phone_number"
    t.string   "alternate_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "contacts", ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id", using: :btree

  create_table "joined_carpools", force: :cascade do |t|
    t.integer  "carpool_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "activated",  default: false
    t.string   "join_token"
  end

  create_table "medicals", force: :cascade do |t|
    t.integer  "child_id"
    t.string   "conditions"
    t.string   "medications"
    t.string   "notes"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "allergies"
    t.string   "insurance"
    t.string   "religious_preference"
    t.string   "blood_type"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "carpool_id"
    t.integer  "user_id"
    t.string   "urgency"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "riders", force: :cascade do |t|
    t.integer  "appointment_id"
    t.integer  "ridable_id"
    t.string   "ridable_type"
    t.integer  "distance_from_origin"
    t.integer  "distance_from_destination"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "rider_role"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "phone_number"
    t.string   "email"
    t.string   "avatar"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "activated",      default: false
    t.string   "access_token"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "activate_token"
  end

end
