class CreateShineAuthors < ActiveRecord::Migration
  def change
    create_table :shine_authors, id: :uuid do |t|
      t.uuid   :user_id, null: false
      t.string :website
      t.string :profile_photo_id
      t.text   :biography

      t.timestamps null: false
    end
    add_index "shine_authors", ["cid"], name: "index_shine_authors_on_cid", unique: true, using: :btree
  end
end
