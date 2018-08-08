class User < ApplicationRecord
  has_secure_password validations: true
  has_many :tasks
end
