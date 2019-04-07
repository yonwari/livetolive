class RenameComedinasToComedians < ActiveRecord::Migration[5.2]
  def change
    rename_table :comedinas, :comedians
  end
end
