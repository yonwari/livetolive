class AddReferencesToEventComedians < ActiveRecord::Migration[5.2]
  def change
    remove_column :event_comedians, :comedian_id, :integer
    remove_column :event_comedians, :event_id, :integer
    add_reference :event_comedians, :comedian, foreign_key: true
    add_reference :event_comedians, :event, foreign_key: true
  end
end
