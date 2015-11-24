class DeviseCreateShineUsers < ActiveRecord::Migration
  def change
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
      t.string :name,           null: false
      t.string :display_email
      t.string :role,           null: false
      t.text   :biography,      null: false
      t.uuid   :profile_photo_id
      t.jsonb  :social # twitter, website, G+, etc.

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :shine_users, :email,                unique: true
    add_index :shine_users, :reset_password_token, unique: true
    add_index :shine_users, :confirmation_token,   unique: true
  end
end
