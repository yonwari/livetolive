class AddReferencesToCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :calendar_events, :user_id, :integer
    remove_column :calendar_events, :event_id, :integer
    add_reference :calendar_events, :user, foreign_key: true
    add_reference :calendar_events, :event, foreign_key: true
  end
end
