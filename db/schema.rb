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

ActiveRecord::Schema.define(:version => 20110815000306) do

  create_table "games", :force => true do |t|
    t.integer  "player1_id"
    t.string   "player1_name"
    t.integer  "player2_id"
    t.string   "player2_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "game_begun",     :default => false
    t.boolean  "game_over",      :default => false
    t.integer  "current_turn",   :default => 1
    t.integer  "current_player"
    t.string   "game_board"
    t.integer  "rows"
    t.integer  "columns"
    t.integer  "to_win"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
