class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors, id: :uuid do |t|
      t.string :cid, null: false
      t.uuid   :sync_session_id

      t.string :name, null: false
      t.string :website
      t.string :profile_photo_cid
      t.text   :biography

      t.timestamps null: false
    end
    add_index "authors", ["cid"], name: "index_authors_on_cid", unique: true, using: :btree
  end
end
