require 'rails_helper'
require 'kaminari'

describe 'ラベル' do
  let(:label_name) { 'Label' }
  let!(:user) { create(:user) }
  before do
    visit '/login'
    fill_in I18n.t('views.user.label.user_name'), with: user.name
    fill_in I18n.t('views.user.label.password'), with: 'password'
    click_button I18n.t('views.user.button.log_in')
  end

  context '新規のラベルを作成するとき' do
    it 'ラベルを作成できること' do
      visit new_setting_label_path
      fill_in I18n.t('views.label.label.name'), with: label_name
      click_button I18n.t('views.button.submit')
      expect(Label.exists?(user_id: user.id)).to be true
      expect(page).to have_content label_name
    end

    it '作成完了のフラッシュメッセージを表示すること' do
      visit new_setting_label_path
      fill_in I18n.t('views.label.label.name'), with: label_name
      click_button I18n.t('views.button.submit')
      expect(Label.exists?(user_id: user.id)).to be true
      expect(page).to have_content I18n.t('views.label.message.created')
    end
  end
end
