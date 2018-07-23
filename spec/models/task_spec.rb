require 'rails_helper'

describe 'Task' do
  describe '#title' do
    let(:task) { build(:task) }
    it '正常に保存ができること' do
      expect(task).to be_valid
    end

    it '空欄とき、保存ができないこと' do
      task.title = ''
      task.valid?
      expect(task.errors.details[:title].any? { |e| e[:error] == :blank }).to be true
    end

    it '100文字以内なら保存ができること' do
      task.title = 'a' * 100
      expect(task).to be_valid
    end

    it '101文字以上だと保存ができないこと' do
      task.title = 'a' * 101
      task.valid?
      expect(task.errors.details[:title].any? { |e| e[:error] == :too_long }).to be true
    end
  end

  describe '#description' do
    let(:task) { build(:task) }
    it '255文字以内なら保存ができること' do
      task.description = 'a' * 255
      expect(task).to be_valid
    end

    it '256文字以上なら保存ができないこと' do
      task.description = 'a' * 256
      task.valid?
      expect(task.errors.details[:description].any? { |e| e[:error] == :too_long }).to be true
    end
  end

  describe '#search' do
    let!(:come_up_task) { create(:task) }
    context '#search_by_title' do
      let!(:not_come_up_task) { create(:task, title: '検索にヒットしないタスク' ) }
      it '入力した文字列を含むタイトルを持つタスクを返す' do
        expect(Task.search_by_title('テスト')).to include(come_up_task)
        expect(Task.search_by_title('テスト')).not_to include(not_come_up_task)
      end
    end

    context '#search_by_status' do
      let!(:not_come_up_task) { create(:task, status: 'doing') }
      it '指定されたステータスのタスクを返す' do
        expect(Task.search_by_status('todo')).to include(come_up_task)
        expect(Task.search_by_status('todo')).not_to include(not_come_up_task)
      end
    end
  end
end
