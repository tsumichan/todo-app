FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}"}
    password 'password'
    role 1

    factory :admin do
      sequence(:name) { |n| "admin_user#{n}"}
      password 'password'
      role 1
    end

    factory :common_user do
      sequence(:name) { |n| "common_user#{n}"}
      password 'password'
      role 0
    end
  end
end
