class CreateShineTables < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :shine_categories, id: :uuid do |t|
      t.string :title,            null: false
      t.text   :short_description
      t.uuid   :icon_id,          null: false

      t.timestamps                null: false
    end

    create_table :shine_assets, id: :uuid do |t|
      t.json   :file,       null: false
      t.string :title
      t.text   :description
      t.uuid   :post_id
      t.uuid   :user_id,    null: false

      t.timestamps          null: false
    end

    create_table :shine_posts, id: :uuid do |t|
      t.string    :title,         null: false
      t.string    :subtitle
      t.text      :body,          null: false
      t.text      :excerpt,       null: false
      t.string    :slug,          null: false
      t.string    :tags,                       array: true, default: []
      t.boolean   :comments,      null: false
      t.uuid      :featured_image_id
      t.uuid      :user_ids,      null: false, array: true, default: []
      t.uuid      :category_ids,  null: false, array: true, default: []
      t.string    :status,        null: false
      t.timestamps                null: false
    end
    add_index "shine_posts", ["slug"], name: "index_shine_posts_on_slug", unique: true, using: :btree
  end

    create_table :shine_users, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## CMS
      t.string :role,           null: false
      t.text   :biography,      null: false
      t.uuid   :profile_photo_id
      t.jsonb  :social # twitter, website, G+, etc.

      t.timestamps null: false
    end

    add_index :shine_users, :email,                unique: true
    add_index :shine_users, :reset_password_token, unique: true
    add_index :shine_users, :confirmation_token,   unique: true
  end


end

