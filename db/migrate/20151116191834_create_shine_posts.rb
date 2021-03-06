class CreateShinePosts < ActiveRecord::Migration
  def change
    create_table :shine_posts, id: :uuid do |t|
      t.string    :title,         null: false
      t.string    :subtitle
      t.text      :body,          null: false
      t.text      :excerpt,       null: false
      t.string    :slug,          null: false
      t.string    :tags,                       array: true, default: []
      t.boolean   :comments,      null: false
      t.uuid      :featured_image_id
      t.uuid      :user_ids,      null: false, array: true, default: []
      t.uuid      :category_ids,  null: false, array: true, default: []
      t.string    :status,        null: false
      
      t.datetime  :published_at
      t.timestamps                null: false
    end
    add_index "shine_posts", ["slug"], name: "index_shine_posts_on_slug", unique: true, using: :btree
  end
end
