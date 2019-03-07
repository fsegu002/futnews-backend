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

ActiveRecord::Schema.define(version: 2019_03_07_024222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.integer "match_day"
    t.datetime "utc_date"
    t.integer "home_team"
    t.integer "away_team"
    t.string "status"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "match_id"
  end

  create_table "play_types", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon_url"
    t.index ["code"], name: "index_play_types_on_code", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.date "date_of_birth"
    t.string "country_of_birth"
    t.string "nationality"
    t.integer "shirt_number"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "team_id"
    t.bigint "player_id"
    t.bigint "play_type_id"
    t.integer "minute"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["match_id"], name: "index_posts_on_match_id"
    t.index ["play_type_id"], name: "index_posts_on_play_type_id"
    t.index ["player_id"], name: "index_posts_on_player_id"
    t.index ["team_id"], name: "index_posts_on_team_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "team_id"
    t.string "name"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name"
    t.string "crest_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "players", "teams"
  add_foreign_key "posts", "matches"
  add_foreign_key "posts", "play_types"
  add_foreign_key "posts", "players"
  add_foreign_key "posts", "teams"
  add_foreign_key "posts", "users"
end
