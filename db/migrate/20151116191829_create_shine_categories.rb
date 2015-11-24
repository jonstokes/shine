class CreateShineCategories < ActiveRecord::Migration
  def change
    create_table :shine_categories, id: :uuid do |t|
      t.string :title, null: false
      t.text   :short_description
      t.string :icon_id

      t.timestamps     null: false
    end
  end
end
