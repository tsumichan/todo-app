class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }

  def self.search(key)
    self.where('title LIKE ?', "%#{key}%")
  end
end
