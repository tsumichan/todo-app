class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  enum role: { common: 0, admin: 1 }
end
