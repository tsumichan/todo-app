class User < ApplicationRecord
  has_secure_password
  before_destroy :cancel_destroy_last_admin
  has_many :tasks, dependent: :destroy
  enum role: { common: 0, admin: 1 }
  has_many :labels, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }, uniqueness: { case_sensitive: false }, on: :create
  validates :password, presence: true, length: { minimum:8, maximum: 100 }, on: :create
  validates :role, presence: true

  def cancel_destroy_last_admin
    throw :abort if User.admin.count == 1 && self.admin?
  end
end
