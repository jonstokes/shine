class CreateShineAssets < ActiveRecord::Migration
  def change
    create_table :shine_assets, id: :uuid do |t|
      t.json   :file,       null: false
      t.string :title
      t.text   :description
      t.uuid   :post_id
      t.uuid   :user_id,    null: false

      t.timestamps          null: false
    end
  end
end