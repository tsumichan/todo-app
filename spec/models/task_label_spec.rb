require 'rails_helper'

describe 'TaskLabel' do
  let!(:user) { create(:user) }
  let!(:label) { create(:label, user_id: user.id) }
  let!(:task) { create(:task, label_ids: [label.id]) }
  it '重複したレコードが保存できないこと' do
    other_task = Task.new(id: task.id, user_id: task.user_id, title: task.title, label_ids: [task.labels.last.id])
    other_task.valid?
    expect(other_task.errors.details[:task_labels].any? { |e| e[:error] == :invalid }).to be true
  end
end
