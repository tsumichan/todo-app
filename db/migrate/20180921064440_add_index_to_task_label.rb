class AddIndexToTaskLabel < ActiveRecord::Migration[5.2]
  def change
    add_index :task_labels, [:task_id, :label_id], unique: true
  end
end
