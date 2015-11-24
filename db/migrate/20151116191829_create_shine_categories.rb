class CreateShineCategories < ActiveRecord::Migration
  def change
    create_table :shine_categories, id: :uuid do |t|
      t.string :title,            null: false
      t.text   :short_description
      t.uuid   :icon_id,          null: false

      t.timestamps                null: false
    end
  end
end
