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

ActiveRecord::Schema.define(version: 20151116225306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "assets", force: :cascade do |t|
    t.string   "cid",             null: false
    t.uuid     "sync_session_id"
    t.json     "file",            null: false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "assets", ["cid"], name: "index_assets_on_cid", unique: true, using: :btree

  create_table "authors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "cid",               null: false
    t.uuid     "sync_session_id"
    t.string   "name",              null: false
    t.string   "website"
    t.string   "profile_photo_cid"
    t.text     "biography"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "authors", ["cid"], name: "index_authors_on_cid", unique: true, using: :btree

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "cid",               null: false
    t.uuid     "sync_session_id"
    t.string   "title",             null: false
    t.text     "short_description"
    t.string   "icon_cid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "categories", ["cid"], name: "index_categories_on_cid", unique: true, using: :btree

  create_table "posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "cid",                             null: false
    t.uuid     "sync_session_id"
    t.string   "title",                           null: false
    t.string   "slug",                            null: false
    t.string   "author_cids",        default: [], null: false, array: true
    t.text     "body",                            null: false
    t.string   "category_cids",      default: [], null: false, array: true
    t.string   "tags",               default: [],              array: true
    t.string   "featured_image_cid"
    t.date     "date",                            null: false
    t.boolean  "comments",                        null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "posts", ["cid"], name: "index_posts_on_cid", unique: true, using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "sync_sessions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "status",        null: false
    t.string   "error"
    t.string   "mode",          null: false
    t.string   "next_sync_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
