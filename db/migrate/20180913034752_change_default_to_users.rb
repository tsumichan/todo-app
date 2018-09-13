class ChangeDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :tasks_count, from: nil, to: 0
  end
end
