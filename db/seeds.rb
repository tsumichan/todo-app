require 'faker'

10.times do |i|
  Task.create(
    title: "タスク#{i}",
    description:  "これはタスク#{i}です",
    priority: Faker::Number.between(0, 3),
    status: Faker::Number.between(0, 2),
    due_at: Faker::Time.forward(60, :all),
    created_at: Faker::Time.backward(30, :all)
  )
end
