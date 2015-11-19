class CreateSync < ActiveRecord::Migration
  def change
    create_table :sync_sessions, id: :uuid do |t|
      t.string :status, null: false
      t.string :error
      t.string :mode, null: false
      t.string :next_sync_url
      t.timestamps null: false
    end
  end
end
