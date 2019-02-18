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

ActiveRecord::Schema.define(version: 20190216171244) do

  create_table "book_clubs", force: :cascade do |t|
    t.string "name"
    t.string "about"
    t.string "organizer"
  end

  create_table "logs", force: :cascade do |t|
    t.string  "book_title"
    t.string  "start_page"
    t.string  "end_page"
    t.string  "summary"
    t.string  "techniques"
    t.string  "characters"
    t.string  "word_choice"
    t.string  "metacognition"
    t.string  "question"
    t.integer "user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string  "topic"
    t.string  "date_and_time"
    t.string  "location"
    t.integer "book_club_id"
  end

  create_table "user_meetings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "meeting_id"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "email"
    t.string  "password_digest"
    t.integer "book_club_id"
  end

end
