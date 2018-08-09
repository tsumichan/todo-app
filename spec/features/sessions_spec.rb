require 'rails_helper'

describe 'ログイン' do
  let(:user_name) { 'test_user_name' }
  let(:password) { 'password' }
  let!(:user) { create :user }
  context 'ログインするとき' do
    it '正常にログインができること' do
      visit '/login'
      fill_in I18n.t('views.user.label.user_name'), with: user_name
      fill_in I18n.t('views.user.label.password'), with: password
      click_button I18n.t('views.user.button.log_in')
      expect(current_path).to eq root_path
      expect(page).to have_content I18n.t('views.header.link.log_out')
    end

    it 'ログイン完了のフラッシュメッセージを表示すること' do
      visit '/login'
      fill_in I18n.t('views.user.label.user_name'), with: user_name
      fill_in I18n.t('views.user.label.password'), with: password
      click_button I18n.t('views.user.button.log_in')
      expect(page).to have_content I18n.t('views.user.message.log_in_success')
    end
  end
end
