class AddReferencesToFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :user_id, :integer
    remove_column :favorites, :event_id, :integer
    add_reference :favorites, :user, foreign_key: true
    add_reference :favorites, :event, foreign_key: true
  end
end
