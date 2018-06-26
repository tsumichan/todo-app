class RemoveUserIdToTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :user_id, :integer
  end
end
