FactoryBot.define do
  factory :task do
    title 'テスト用タスク'
    description 'テスト用タスクです'
    due_at Date.parse('2020-01-01')
    status 'Todo'
    priority '1'

    factory :new_task do
      created_at Date.parse('2020-01-01')
    end

    factory :old_task do
      created_at Date.parse('2000-01-01')
    end

    factory :doing_task do
      status 'Doing'
    end

    factory :sample_title_task do
      title 'サンプル用タスクです'
    end
  end

end
