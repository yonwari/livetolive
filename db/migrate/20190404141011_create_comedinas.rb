class CreateComedinas < ActiveRecord::Migration[5.2]
  def change
    create_table :comedinas do |t|
      t.string :comedian_name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
