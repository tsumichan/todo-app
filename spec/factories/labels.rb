FactoryBot.define do
  factory :label do
    name { "Label1" }
    user { create(:user) }
  end
end
