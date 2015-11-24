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

  create_table "shine_assets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.json     "file",        null: false
    t.string   "title"
    t.text     "description"
    t.uuid     "post_id"
    t.uuid     "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shine_categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",             null: false
    t.text     "short_description"
    t.uuid     "icon_id",           null: false
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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "shine_posts", ["slug"], name: "index_shine_posts_on_slug", unique: true, using: :btree

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
    t.string   "role",                                null: false
    t.text     "biography",                           null: false
    t.uuid     "profile_photo_id"
    t.jsonb    "social"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "shine_users", ["confirmation_token"], name: "index_shine_users_on_confirmation_token", unique: true, using: :btree
  add_index "shine_users", ["email"], name: "index_shine_users_on_email", unique: true, using: :btree
  add_index "shine_users", ["reset_password_token"], name: "index_shine_users_on_reset_password_token", unique: true, using: :btree

end
