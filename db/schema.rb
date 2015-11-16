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

ActiveRecord::Schema.define(version: 20151116000540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "author_posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "author_id"
    t.uuid     "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "author_posts", ["author_id"], name: "index_author_posts_on_author_id", using: :btree
  add_index "author_posts", ["post_id"], name: "index_author_posts_on_post_id", using: :btree

  create_table "authors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "contentful_id", null: false
    t.string   "name",          null: false
    t.string   "website"
    t.jsonb    "profile_photo"
    t.text     "biography"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "authors", ["contentful_id"], name: "index_authors_on_contentful_id", using: :btree

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "contentful_id",     null: false
    t.string   "title",             null: false
    t.text     "short_description"
    t.jsonb    "icon"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "categories", ["contentful_id"], name: "index_categories_on_contentful_id", using: :btree

  create_table "category_posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "category_id"
    t.uuid     "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_posts", ["category_id"], name: "index_category_posts_on_author_id", using: :btree
  add_index "category_posts", ["post_id"], name: "index_category_posts_on_post_id", using: :btree

  create_table "posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "contentful_id",               null: false
    t.string   "title",                       null: false
    t.string   "slug",                        null: false
    t.jsonb    "author",                      null: false
    t.text     "body",                        null: false
    t.jsonb    "category",                    null: false
    t.string   "tags",           default: [],              array: true
    t.jsonb    "featured_image"
    t.date     "date",                        null: false
    t.boolean  "comments",                    null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "posts", ["contentful_id"], name: "index_posts_on_contentful_id", using: :btree

end
