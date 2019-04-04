class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event_title
      t.datetime :start_date
      t.datetime :end_date
      t.integer :place_id
      t.text :explanation
      t.text :reserve_url
      t.datetime :open_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
