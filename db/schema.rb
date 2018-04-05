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

ActiveRecord::Schema.define(version: 20180405202529) do

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "department"
    t.string "location"
    t.string "professor"
    t.integer "user_id"
    t.integer "semeser_id"
    t.integer "semester_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.string "season"
    t.integer "year"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
