class CreateSync < ActiveRecord::Migration
  def change
    create_table :sync_sessions, id: :uuid do |t|
      t.string :status
      t.string :error
      t.timestamps null: false
    end
  end
end
