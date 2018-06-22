class ChangeNotnullAndDefaultToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :user_id, false
    change_column_null :tasks, :title, false
    change_column_default :tasks, :status, from: nil, to: 0
    change_column_default :tasks, :priority, from: nil, to: 0
  end
end
