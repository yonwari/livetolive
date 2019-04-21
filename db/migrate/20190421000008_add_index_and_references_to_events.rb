class AddIndexAndReferencesToEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :place_id, :integer
    add_index :events, :event_title
    add_reference :events, :place, foreign_key: true
  end
end
