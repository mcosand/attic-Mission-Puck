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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130429003423) do

  create_table "commands", :id => false, :force => true do |t|
    t.uuid     "id",        :primary_key => true
    t.string   "type"
    t.uuid     "reference"
    t.datetime "when"
    t.string   "source"
    t.text     "data"
  end


  create_table "dummy", :force => true do |t|
    t.string "title"
  end

  create_table "logs", :id => false, :force => true do |t|
    t.uuid     "id",                         :primary_key => true
    t.text     "message",    :null => false
    t.datetime "when",       :null => false
    t.uuid     "mission_id", :null => false
  end

  add_index "logs", ["mission_id"], :name => "index_logs_on_mission_id"

  create_table "missions", :id => false, :force => true do |t|
    t.uuid     "id",       :primary_key => true
    t.string   "title"
    t.datetime "started"
    t.string   "number"
    t.string   "county"
    t.text     "briefing"
  end


  create_table "responders", :id => false, :force => true do |t|
    t.uuid   "id",                         :primary_key => true
    t.uuid   "mission_id", :null => false
    t.uuid   "current_id"
    t.uuid   "member_id"
    t.string "firstname"
    t.string "lastname"
    t.string "number"
    t.uuid   "team_id"
  end


  create_table "roster_timelines", :id => false, :force => true do |t|
    t.uuid     "id",                           :primary_key => true
    t.uuid     "responder_id", :null => false
    t.uuid     "unit_id",      :null => false
    t.string   "status"
    t.string   "role"
    t.datetime "time"
    t.integer  "miles"
  end


  create_table "teams", :id => false, :force => true do |t|
    t.uuid   "id",                         :primary_key => true
    t.uuid   "mission_id", :null => false
    t.uuid   "leader_id"
    t.string "name"
    t.string "kind"
  end


  create_table "units", :id => false, :force => true do |t|
    t.uuid   "id",         :primary_key => true
    t.uuid   "mission_id"
    t.string "name"
    t.string "longname"
  end


end
