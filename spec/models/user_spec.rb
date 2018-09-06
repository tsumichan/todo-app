require 'rails_helper'

describe 'User' do
  describe '#name'do
    let(:user) { build(:user) }
    let(:other_user) { create(:user) }
    it '正常に保存ができること' do
      expect(user).to be_valid
    end

    it '空欄のとき、保存ができないこと' do
      user.name = ''
      user.valid?
      expect(user.errors.details[:name].any? { |e| e[:error] == :blank }).to be true
    end

    it '同じ文字列を name に持つユーザーがいた場合、保存ができないこと' do
      user.name = other_user.name
      user.valid?
      expect(user.errors.details[:name].any? { |e| e[:error] == :taken }).to be true
    end

    it '大文字<->小文字の違いでも、同じ文字列の name だと保存ができないこと' do
      user.name = other_user.name.upcase
      user.valid?
      expect(user.errors.details[:name].any? { |e| e[:error] == :taken }).to be true
    end

    it '4文字以下だと保存ができないこと' do
      user.name = 'a' * 4
      user.valid?
      expect(user.errors.details[:name].any? { |e| e[:error] == :too_short }).to be true
    end

    it '26文字以上だと保存ができないこと' do
      user.name = 'a' * 26
      user.valid?
      expect(user.errors.details[:name].any? { |e| e[:error] == :too_long }).to be true
    end
  end

  describe '#password' do
    let(:user) { build(:user, password: '') }
    it '正常に保存ができること' do
      user.password = 'password'
      expect(user).to be_valid
    end

    it '空欄のとき、保存ができないこと' do
      user.valid?
      expect(user.errors.details[:password].any? { |e| e[:error] == :blank }).to be true
    end

    it '7文字以下だと保存ができないこと' do
      user.password = 'a' * 7
      user.valid?
      expect(user.errors.details[:password].any? { |e| e[:error] == :too_short }).to be true
    end

    it '101文字以上だと保存ができないこと' do
      user.password = 'a' * 101
      user.valid?
      expect(user.errors.details[:password].any? { |e| e[:error] == :too_long }).to be true
    end
  end

  describe '#role' do
    let(:user) { build(:user) }
    it '正常に保存ができること' do
      expect(user).to be_valid
    end

    it '空欄のとき、保存ができないこと' do
      user.role = ''
      user.valid?
      expect(user.errors.details[:role].any? { |e| e[:error] == :blank }).to be true
    end
  end
end
