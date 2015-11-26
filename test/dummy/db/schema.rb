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

ActiveRecord::Schema.define(version: 20151124164133) do

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

  create_table "author_posts", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "author_id"
    t.uuid     "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "author_posts", ["author_id"], name: "index_author_posts_on_author_id", using: :btree
  add_index "author_posts", ["post_id"], name: "index_author_posts_on_post_id", using: :btree

  create_table "authors", id: :uuid, default: nil, force: :cascade do |t|
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

  create_table "categories", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "cid",               null: false
    t.uuid     "sync_session_id"
    t.string   "title",             null: false
    t.text     "short_description"
    t.string   "icon_cid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "categories", ["cid"], name: "index_categories_on_cid", unique: true, using: :btree

  create_table "category_posts", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "category_id"
    t.uuid     "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_posts", ["category_id"], name: "index_category_posts_on_author_id", using: :btree
  add_index "category_posts", ["post_id"], name: "index_category_posts_on_post_id", using: :btree

  create_table "posts", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "cid",                             null: false
    t.uuid     "sync_session_id"
    t.string   "title",                           null: false
    t.string   "slug",                            null: false
    t.string   "author_cids",        default: [], null: false, array: true
    t.text     "body",                            null: false
    t.string   "category_cids",      default: [], null: false, array: true
    t.string   "tags",               default: [],              array: true
    t.string   "featured_image_cid"
    t.date     "date"
    t.boolean  "comments",                        null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "posts", ["cid"], name: "index_posts_on_cid", unique: true, using: :btree

  create_table "shine_assets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.json     "file",        null: false
    t.string   "title"
    t.text     "credit"
    t.text     "caption"
    t.text     "description"
    t.text     "alt_text"
    t.uuid     "post_id"
    t.uuid     "user_id",     null: false
    t.datetime "uploaded_at", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shine_authors", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "cid",               null: false
    t.uuid     "sync_session_id"
    t.string   "name",              null: false
    t.string   "website"
    t.string   "profile_photo_cid"
    t.text     "biography"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "shine_authors", ["cid"], name: "index_shine_authors_on_cid", unique: true, using: :btree

  create_table "shine_categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",             null: false
    t.text     "short_description"
    t.uuid     "icon_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "shine_posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",                          null: false
    t.string   "subtitle"
    t.text     "body",                           null: false
    t.text     "excerpt",                        null: false
    t.string   "slug",                           null: false
    t.string   "tags",              default: [],              array: true
    t.boolean  "comments",                       null: false
    t.uuid     "featured_image_id"
    t.uuid     "user_ids",          default: [], null: false, array: true
    t.uuid     "category_ids",      default: [], null: false, array: true
    t.string   "status",                         null: false
    t.datetime "published_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "shine_posts", ["slug"], name: "index_shine_posts_on_slug", unique: true, using: :btree

  create_table "shine_sync_sessions", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "status",        null: false
    t.string   "error"
    t.string   "mode",          null: false
    t.string   "next_sync_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "shine_users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name",                                null: false
    t.string   "display_email"
    t.string   "role",                                null: false
    t.text     "biography",                           null: false
    t.uuid     "profile_photo_id"
    t.jsonb    "social"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "shine_users", ["confirmation_token"], name: "index_shine_users_on_confirmation_token", unique: true, using: :btree
  add_index "shine_users", ["display_email"], name: "index_shine_users_on_display_email", unique: true, using: :btree
  add_index "shine_users", ["email"], name: "index_shine_users_on_email", unique: true, using: :btree
  add_index "shine_users", ["reset_password_token"], name: "index_shine_users_on_reset_password_token", unique: true, using: :btree

  create_table "sync_sessions", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "status",        null: false
    t.string   "error"
    t.string   "mode",          null: false
    t.string   "next_sync_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
