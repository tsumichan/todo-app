class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.datetime :due_at
      t.integer :status
      t.integer :priority

      t.timestamps
    end
  end
end
