class CreateEventComedians < ActiveRecord::Migration[5.2]
  def change
    create_table :event_comedians do |t|
      t.integer :event_id
      t.integer :comedian_id

      t.timestamps
    end
  end
end
