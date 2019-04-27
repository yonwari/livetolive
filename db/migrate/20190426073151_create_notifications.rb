class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :event
      t.boolean :read_flg

      t.timestamps
    end
  end
end
