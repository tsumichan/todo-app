class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  enum role: { admin: 0, common: 1 }
end
