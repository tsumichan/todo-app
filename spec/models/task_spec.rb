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
    let!(:task) { create(:task) }
    context 'タイトルで検索する' do
      let!(:sample_title_task) { create(:sample_title_task) }
      it '入力した文字列を含むタイトルを持つタスクを返す' do
        expect(Task.search('テスト')).to include(task)
        expect(Task.search('テスト')).not_to include(sample_title_task)
      end
    end

    context 'ステータスで検索する' do
      let!(:doing_task) { create(:doing_task) }
      it '指定されたステータスのタスクを返す' do
        expect(Task.search_status('Doing')).to include(doing_task)
        expect(Task.search_status('Doing')).not_to include(task)
      end
    end
  end
end
