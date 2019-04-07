class AddColumnComediansToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :comedians, :text
  end
end
