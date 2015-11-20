class CreateShineCategories < ActiveRecord::Migration
  def change
    create_table :shine_categories, id: :uuid do |t|
      t.string :cid,   null: false
      t.uuid   :sync_session_id

      t.string :title, null: false
      t.text   :short_description
      t.string :icon_cid

      t.timestamps     null: false
    end
    add_index "shine_categories", ["cid"], name: "index_shine_categories_on_cid", unique: true, using: :btree
  end
end
