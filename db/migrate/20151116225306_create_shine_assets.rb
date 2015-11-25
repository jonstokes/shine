class CreateShineAssets < ActiveRecord::Migration
  def change
    create_table :shine_assets, id: :uuid do |t|
      t.json   :file,          null: false
      t.string :title
      t.text   :credit
      t.text   :caption
      t.text   :description
      t.text   :alt_text
      t.uuid   :post_id
      t.uuid   :user_id,       null: false

      t.datetime :uploaded_at, null: false
      t.timestamps             null: false
    end
  end
end