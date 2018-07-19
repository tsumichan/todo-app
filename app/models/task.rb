class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { Todo: 0, Doing:1, Done: 2 }

  scope :search, ->(key) { where('title LIKE ?', "%#{key}%") }
  scope :search_status, ->(key) { where(status: key) if key.present? }
end
