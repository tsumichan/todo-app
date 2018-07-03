FactoryBot.define do
  factory :task do
    title 'テスト用タスク'
    description 'テスト用タスクです'
    due_at Date.parse('2020-01-01')
    status '1'
    priority '1'
  end
end
