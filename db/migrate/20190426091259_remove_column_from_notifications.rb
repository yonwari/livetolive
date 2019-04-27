class RemoveColumnFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :read_flg, :boolean
  end
end
