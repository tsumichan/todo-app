class TaskLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label

  validates :task_id, uniqueness: { scope: :label_id }
end
