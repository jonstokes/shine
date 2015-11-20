class CreateShineTables < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :shine_sync_sessions, id: :uuid do |t|
      t.string :status, null: false
      t.string :error
      t.string :mode, null: false
      t.string :next_sync_url
      t.timestamps null: false
    end

    create_table :shine_authors, id: :uuid do |t|
      t.string :cid, null: false
      t.uuid   :sync_session_id

      t.string :name, null: false
      t.string :website
      t.string :profile_photo_cid
      t.text   :biography

      t.timestamps null: false
    end
    add_index "shine_authors", ["cid"], name: "index_shine_authors_on_cid", unique: true, using: :btree

    create_table :shine_categories, id: :uuid do |t|
      t.string :cid,   null: false
      t.uuid   :sync_session_id

      t.string :title, null: false
      t.text   :short_description
      t.string :icon_cid

      t.timestamps     null: false
    end
    add_index "shine_categories", ["cid"], name: "index_shine_categories_on_cid", unique: true, using: :btree

    create_table :shine_posts, id: :uuid do |t|
      t.string    :cid,           null: false
      t.uuid      :sync_session_id

      t.string    :title,         null: false
      t.string    :subtitle
      t.text      :body,          null: false
      t.string    :slug,          null: false
      t.string    :tags,                       array: true, default: []
      t.date      :date,          null: false
      t.boolean   :comments,      null: false
      t.string    :featured_image_cid
      t.string    :author_cids,   null: false, array: true, default: []
      t.string    :category_cids, null: false, array: true, default: []

      t.timestamps                null: false
    end
    add_index "shine_posts", ["cid"], name: "index_shine_posts_on_cid", unique: true, using: :btree
    add_index "shine_posts", ["slug"], name: "index_shine_posts_on_slug", unique: true, using: :btree

    create_table :shine_assets do |t|
      t.string :cid,  null: false
      t.uuid   :sync_session_id
      t.json   :file, null: false
      t.string :title
      t.text   :description

      t.timestamps   null: false
    end

    add_index "shine_assets", ["cid"], name: "index_shine_assets_on_cid", unique: true, using: :btree
  end
end

