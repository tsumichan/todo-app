require 'rails_helper'

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
