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

ActiveRecord::Schema.define(version: 20160529114414) do

  create_table "players", force: :cascade do |t|
    t.string   "player_id",  limit: 255
    t.string   "nick_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "player_id",    limit: 4
    t.integer  "total_word",   limit: 4
    t.integer  "correct_word", limit: 4
    t.integer  "wrong_guess",  limit: 4
    t.integer  "grade",        limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
