class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { todo: 0, doing: 1, done: 2 }
  enum priority: { nothing: 0, low: 1, middle: 2, high: 3 }
  belongs_to :user, counter_cache: :tasks_count
  has_many :task_labels
  has_many :labels, through: :task_labels

  scope :search_by_title, ->(word) { where('title LIKE ?', "%#{word}%") if word.present? }
  scope :search_by_status, ->(status) { where(status: status) if status.present? }
  scope :order_by, ->(sort) {
    option = case sort.to_i
      when 1
        { due_at: :asc }
      when 2
        { priority: :desc }
      when 3
        { priority: :asc }
      else
        { created_at: :desc }
      end
    order(option)
  }
  scope :search_by_labels, -> label_ids {
    joins(:task_labels).where(task_labels: { label_id: label_ids }).distinct if label_ids.present?
  }
end
