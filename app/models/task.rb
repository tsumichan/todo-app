class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { Todo: 0, Doing: 1, Done: 2 }

  scope :search, ->(word) { where('title LIKE ?', "%#{word}%") }
  scope :search_status, ->(status) { where(status: status) if status.present? }
end
