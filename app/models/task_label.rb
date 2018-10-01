class TaskLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label

  validates_uniqueness_of :task_id, scope: :label_id
end
