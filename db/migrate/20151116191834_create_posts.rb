class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.string :cid, null: false
      t.uuid :sync_session_id

      t.string    :title,         null: false
      t.string    :slug,          null: false
      t.string    :author_cids,   null: false, array: true, default: []
      t.text      :body,          null: false
      t.string    :category_cids, null: false, array: true, default: []
      t.string    :tags,                       array: true, default: []
      t.string    :featured_image_cid
      t.date      :date,          null: false
      t.boolean   :comments,      null: false

      t.timestamps                null: false
    end
    add_index "posts", ["cid"], name: "index_posts_on_cid", unique: true, using: :btree
    add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  end
end
