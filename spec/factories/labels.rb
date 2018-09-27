FactoryBot.define do
  factory :label do
    user { create(:user) }
    sequence(:name) { |n| "Label#{n}"}
  end
end
