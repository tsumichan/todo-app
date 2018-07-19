class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { todo: 0, doing: 1, done: 2 }

  scope :search, ->(word) { where('title LIKE ?', "%#{word}%") if word.present? }
  scope :search_status, ->(status) { where(status: status) if status.present? }
end
