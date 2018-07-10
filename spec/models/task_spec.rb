require 'rails_helper'

describe 'タスク' do
  context 'タスクを作成する' do
    it '正常に保存ができること' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'タスク名が空欄とき、保存ができないこと' do
      task = build(:task)
      task.title = ''
      task.valid?
      expect(task.errors.details[:title].any? { |e| e[:error] == :blank }).to be true
    end

    it 'タスク名が100文字以内なら保存ができること' do
      task = build(:task)
      task.title = 'a' * 100
      expect(task).to be_valid
    end

    it 'タスク名が101文字以上だと保存ができないこと' do
      task = build(:task)
      task.title = 'a' * 101
      task.valid?
      expect(task.errors.details[:title].any? { |e| e[:error] == :too_long }).to be true
    end

    it 'タスクの説明文が255文字以内なら保存ができること' do
      task = build(:task)
      task.description = 'a' * 255
      expect(task).to be_valid
    end

    it 'タスクの説明文が256文字以上なら保存ができないこと' do
      task = build(:task)
      task.description = 'a' * 256
      task.valid?
      expect(task.errors.details[:description].any? { |e| e[:error] == :too_long }).to be true
    end
  end
end
