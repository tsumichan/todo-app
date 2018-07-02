FactoryBot.define do
  factory :task do
    title 'テスト用タスク'
    description 'テスト用タスクです'
    due_at '2020-01-01 00:00:00'
    status '1'
    priority '1'
  end
end
