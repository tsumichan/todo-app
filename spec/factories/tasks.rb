FactoryBot.define do
  factory :task do
    title 'テスト用タスク'
    description 'テスト用タスクです'
    due_at Date.parse('2020-01-01')
    status 'todo'
    priority 'nothing'

    factory :new_task do
      created_at Date.parse('2020-01-01')
    end

    factory :old_task do
      created_at Date.parse('2000-01-01')
    end

    factory :approaching_task do
      due_at Date.parse('2000-01-01')
    end

    factory :not_approaching_task do
      due_at Date.today
    end

    factory :high_priority_task do
      priority 'high'
    end

    factory :low_priority_task do
      priority 'low'
    end
  end
end
