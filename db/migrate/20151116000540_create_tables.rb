class CreateTables < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.jsonb  :data,          null: false
      t.string :contentful_id, null: false
      t.uuid   :author_id,     null: false
      t.uuid   :category_id,   null: false

      t.timestamps             null: false
    end

    create_table :authors, id: :uuid do |t|
      t.jsonb  :data,          null: false
      t.string :contentful_id, null: false

      t.timestamps             null: false
    end

    create_table :categories, id: :uuid do |t|
      t.jsonb  :data,          null: false
      t.string :contentful_id, null: false

      t.timestamps             null: false
    end

    add_index "posts", ["contentful_id"], name: "index_posts_on_contentful_id", using: :btree
    add_index "authors", ["contentful_id"], name: "index_authors_on_contentful_id", using: :btree
    add_index "categories", ["contentful_id"], name: "index_categories_on_contentful_id", using: :btree
  end
end
