class CreateShinePosts < ActiveRecord::Migration
  def change
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
  end
end
