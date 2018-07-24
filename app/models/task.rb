class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  enum status: { todo: 0, doing: 1, done: 2 }
  enum priority: { nothing: 0, low: 1, middle: 2, high: 3 }

  scope :search_by_title, ->(word) { where('title LIKE ?', "%#{word}%") if word.present? }
  scope :search_by_status, ->(status) { where(status: status) if status.present? }
  scope :sort_by_priority, ->(sort) {
    if sort.present?
      option = case sort.to_i
           when 1
             :asc
           else
             :desc
           end
      order(priority: option)
    end
  }
  scope :sort_by_due_at, ->(sort) {
    option = case sort.to_i
         when 1
           { due_at: :asc }
         else
           { created_at: :desc }
         end
    order(option)
  }
end
