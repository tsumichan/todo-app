require 'faker'

50.times do |i|
  Task.create(
    title: "タスク#{i}",
    description:  "これはタスク#{i}です",
    priority: Faker::Number.between(0, 3),
    status: Faker::Number.between(0, 2),
    due_at: Faker::Time.forward(60, :all),
    created_at: Faker::Time.backward(30, :all),
    user_id: Faker::Number.between(1, 10)
  )
end

10.times do |i|
  User.create(
    name: Faker::Internet.user_name,
    password:  Faker::Internet.password,
    role: Faker::Number.between(0, 1)
  )
end
