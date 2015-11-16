class CreateTables < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.string  :contentful_id,  null: false

      t.string  :title,          null: false
      t.string  :slug,           null: false
      t.jsonb   :author,         null: false
      t.text    :body,           null: false
      t.jsonb   :category,       null: false
      t.string  :tags,                      array: true, default: []
      t.jsonb   :featured_image
      t.date    :date,           null: false
      t.boolean :comments,       null: false

      t.timestamps              null: false
    end
    add_index "posts", ["contentful_id"], name: "index_posts_on_contentful_id", using: :btree

    create_table :authors, id: :uuid do |t|
      t.string :contentful_id, null: false

      t.string :name,          null: false
      t.string :website
      t.jsonb  :profile_photo
      t.text   :biography

      t.timestamps             null: false
    end
    add_index "authors", ["contentful_id"], name: "index_authors_on_contentful_id", using: :btree

    create_table :categories, id: :uuid do |t|
      t.string :contentful_id, null: false

      t.string :title          null: false
      t.text   :short_description
      t.jsonb  :icon

      t.timestamps             null: false
    end
    add_index "categories", ["contentful_id"], name: "index_categories_on_contentful_id", using: :btree

    create_table :author_post, id: :uuid do |t|
      t.uuid :author_id
      t.uuid :post_id

      t.timestamps
    end
    add_index "author_posts", ["author_id"], name: "index_author_posts_on_author_id", using: :btree
    add_index "author_posts", ["post_id"], name: "index_author_posts_on_post_id", using: :btree

    create_table :category_post, id: :uuid do |t|
      t.uuid :category_id
      t.uuid :post_id

      t.timestamps
    end
    add_index "category_posts", ["author_id"], name: "index_category_posts_on_author_id", using: :btree
    add_index "category_posts", ["post_id"], name: "index_category_posts_on_post_id", using: :btree
  end
end
