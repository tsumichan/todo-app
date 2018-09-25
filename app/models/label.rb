class Label < ApplicationRecord
  has_many :task_labels
  has_many :tasks, through: :task_labels
  belongs_to :user

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
end
