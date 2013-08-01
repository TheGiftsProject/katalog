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

ActiveRecord::Schema.define(version: 20130725135113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.string  "text",       limit: 1024
    t.string  "story",                   default: "nothing"
    t.boolean "updated",                 default: false
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "repo_url"
    t.string   "website_url"
    t.string   "status",           default: "idea"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_commit_date"
  end

  create_table "projects_tags", force: true do |t|
    t.integer "project_id"
    t.integer "tag_id"
  end

  create_table "projects_users", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
