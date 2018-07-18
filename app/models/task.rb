class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { waiting: 0, working:1, completed: 2 }

  scope :search, ->(key) { where('title LIKE ?', "%#{key}%") }
  scope :search_status, ->(key) { where(status: key) if key.present? }
end
