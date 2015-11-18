class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, id: :uuid do |t|
      t.string :cid, null: false
      t.uuid   :sync_session_id

      t.string :title, null: false
      t.text   :short_description
      t.string :icon_cid

      t.timestamps null: false
    end
    add_index "categories", ["cid"], name: "index_categories_on_cid", unique: true, using: :btree
  end
end
