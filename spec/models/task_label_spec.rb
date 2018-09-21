require 'rails_helper'

describe 'TaskLabel' do
  let(:task) { build(:task) }
  it '重複したレコードが保存できないこと' do
    other_task = Task.new(id: task.id, label_ids: [task.labels.first.id])
    other_task_label.valid?
    expect(other_task_label.errors.details[:task_id].any? { |e| e[:error] == :taken }).to be true
  end
end
