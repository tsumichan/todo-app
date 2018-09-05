class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  enum role: { common: 0, admin: 1 }

  validates :name, presence: true, length: { minimum: 5, maximum: 25 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum:8, maximum: 100 }
  validates :role, presence: true
end
