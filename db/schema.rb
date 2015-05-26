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

ActiveRecord::Schema.define(version: 20150526190212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bet_summoner_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "summoner_id"
    t.integer  "bet_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bet_summoner_users", ["bet_id"], name: "index_bet_summoner_users_on_bet_id", using: :btree
  add_index "bet_summoner_users", ["summoner_id"], name: "index_bet_summoner_users_on_summoner_id", using: :btree
  add_index "bet_summoner_users", ["user_id"], name: "index_bet_summoner_users_on_user_id", using: :btree

  create_table "bet_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bet_users", ["bet_id"], name: "index_bet_users_on_bet_id", using: :btree
  add_index "bet_users", ["user_id"], name: "index_bet_users_on_user_id", using: :btree

  create_table "bets", force: :cascade do |t|
    t.integer  "max_entrants"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "entry_fee_in_cents"
    t.string   "bet_style"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "num_deaths"
    t.integer  "champions_killed"
    t.boolean  "win"
    t.integer  "minions_killed"
    t.datetime "create_date"
    t.integer  "assists"
    t.integer  "total_damage_dealt"
    t.integer  "total_damage_taken"
    t.integer  "total_damage_dealt_to_champion"
    t.integer  "killing_sprees"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "summoner_id"
    t.integer  "lol_game_id"
    t.integer  "barracks_killed"
    t.integer  "combat_player_score"
    t.integer  "consumables_purchased"
    t.integer  "damage_dealt_player"
    t.integer  "double_kills"
    t.integer  "first_blood"
    t.integer  "gold"
    t.integer  "gold_earned"
    t.integer  "gold_spent"
    t.integer  "item0"
    t.integer  "item1"
    t.integer  "item2"
    t.integer  "item3"
    t.integer  "item4"
    t.integer  "item5"
    t.integer  "item6"
    t.integer  "items_purchased"
    t.integer  "largest_critical_strike"
    t.integer  "largest_killing_spree"
    t.integer  "largest_multi_kill"
    t.integer  "legendary_items_created"
    t.integer  "level"
    t.integer  "magic_damage_dealt_player"
    t.integer  "magic_damage_dealt_to_champions"
    t.integer  "magic_damage_taken"
    t.integer  "minions_denied"
    t.integer  "neutral_minions_killed"
    t.integer  "neutral_minions_killed_enemy_jungle"
    t.integer  "neutral_minions_killed_your_jungle"
    t.boolean  "nexus_killed"
    t.integer  "node_capture"
    t.integer  "node_capture_assist"
    t.integer  "node_neutralize"
    t.integer  "node_neutralize_assist"
    t.integer  "num_items_bought"
    t.integer  "objective_player_score"
    t.integer  "penta_kills"
    t.integer  "physical_damage_dealt_player"
    t.integer  "physical_damage_dealt_to_champions"
    t.integer  "physical_damage_taken"
    t.integer  "player_position"
    t.integer  "player_role"
    t.integer  "quadra_kills"
    t.integer  "sight_wards_bought"
    t.integer  "spell_1_cast"
    t.integer  "spell_2_cast"
    t.integer  "spell_3_cast"
    t.integer  "spell_4_cast"
    t.integer  "summon_spell_1_cast"
    t.integer  "summon_spell_2_cast"
    t.integer  "super_monster_killed"
    t.integer  "team"
    t.integer  "team_objective"
    t.integer  "time_played"
    t.integer  "total_heal"
    t.integer  "total_player_score"
    t.integer  "total_score_rank"
    t.integer  "total_time_crowd_control_dealt"
    t.integer  "total_units_healed"
    t.integer  "triple_kills"
    t.integer  "true_damage_dealt_player"
    t.integer  "true_damage_dealt_to_champions"
    t.integer  "true_damage_taken"
    t.integer  "turrets_killed"
    t.integer  "unreal_kills"
    t.integer  "victory_point_total"
    t.integer  "vision_wards_bought"
    t.integer  "ward_killed"
    t.integer  "ward_placed"
  end

  add_index "games", ["summoner_id"], name: "index_games_on_summoner_id", using: :btree

  create_table "games_summoners", force: :cascade do |t|
    t.integer "game_id"
    t.integer "summoner_id"
  end

  add_index "games_summoners", ["game_id"], name: "index_games_summoners_on_game_id", using: :btree
  add_index "games_summoners", ["summoner_id"], name: "index_games_summoners_on_summoner_id", using: :btree

  create_table "summoners", force: :cascade do |t|
    t.integer  "lol_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bet_summoner_users", "bets"
  add_foreign_key "bet_summoner_users", "summoners"
  add_foreign_key "bet_summoner_users", "users"
  add_foreign_key "bet_users", "bets"
  add_foreign_key "bet_users", "users"
  add_foreign_key "games", "summoners"
  add_foreign_key "games_summoners", "games"
  add_foreign_key "games_summoners", "summoners"
end
