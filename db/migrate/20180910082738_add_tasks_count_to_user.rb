class AddTasksCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tasks_count, :integer
  end
end
