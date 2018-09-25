require 'rails_helper'

describe 'Label' do
  describe '#name' do
    let(:label) { build(:label) }
    it '正常に保存できること' do
      expect(label).to be_valid
    end

    it '空欄のとき、保存ができないこと' do
      label.name = ''
      label.valid?
      expect(label.errors.details[:name].any? { |e| e[:error] == :blank }).to be true
    end

    it '15文字以内なら保存ができること' do
      label.name = 'a' * 15
      label.valid?
      expect(label).to be_valid
    end

    it '16文字以上だと保存ができないこと' do
      label.name = 'a' * 16
      label.valid?
      expect(label.errors.details[:name].any? { |e| e[:error] == :too_long }).to be true
    end
  end
end
