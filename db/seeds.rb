require 'faker'

10.times do |i|
  Task.create(
    title: "タスク#{i}",
    description:  "これはタスク#{i}です",
    priority: 0,
    status: Faker::Number.between(0, 2),
    due_at: Faker::Time.forward(60, :all)
  )
end
