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

ActiveRecord::Schema.define(version: 20150215225954) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "content",        limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "author_id",      limit: 4
    t.integer  "comments_count", limit: 4
    t.string   "slug",           limit: 255
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "authors", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "age",            limit: 2
    t.string  "email",          limit: 255
    t.string  "website",        limit: 255
    t.string  "user_name",      limit: 255
    t.integer "videos_count",   limit: 4
    t.integer "articles_count", limit: 4
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",       limit: 65535
    t.integer  "c_object_id",   limit: 4
    t.string   "c_object_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.string   "url",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "author_id",      limit: 4
    t.integer  "comments_count", limit: 4
    t.string   "slug",           limit: 255
  end

  add_index "videos", ["slug"], name: "index_videos_on_slug", unique: true, using: :btree

end
