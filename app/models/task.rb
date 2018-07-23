class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { todo: 0, doing: 1, done: 2 }

  scope :search_by_title, ->(word) { where('title LIKE ?', "%#{word}%") if word.present? }
  scope :search_by_status, ->(status) { where(status: status) if status.present? }
  scope :sort_by_due_at, ->(sort) {
    sort == '1' ? order(due_at: :asc) : order(created_at: :desc) }
end
