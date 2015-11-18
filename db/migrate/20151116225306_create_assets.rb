class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :cid, null: false
      t.uuid   :sync_session_id
      t.json   :file, null: false
      t.string :title
      t.text   :description

      t.timestamps null: false
    end

    add_index "assets", ["cid"], name: "index_assets_on_cid", unique: true, using: :btree
  end
end