require 'rails_helper'
require 'kaminari'

describe 'ラベル' do
  let(:label_name) { 'Label' }
  let(:label_name_edited) { 'Label_edited' }
  let!(:user) { create(:user) }
  before do
    visit '/login'
    fill_in I18n.t('views.user.label.user_name'), with: user.name
    fill_in I18n.t('views.user.label.password'), with: 'password'
    click_button I18n.t('views.user.button.log_in')
  end

  context '新規のラベルを作成するとき' do
    it 'ラベルを作成できること' do
      visit new_label_path
      fill_in I18n.t('views.label.label.name'), with: label_name
      click_button I18n.t('views.button.submit')
      expect(Label.exists?(user_id: user.id)).to be true
      expect(page).to have_content label_name
    end

    it '作成完了のフラッシュメッセージを表示すること' do
      visit new_label_path
      fill_in I18n.t('views.label.label.name'), with: label_name
      click_button I18n.t('views.button.submit')
      expect(Label.exists?(user_id: user.id)).to be true
      expect(page).to have_content I18n.t('views.label.message.created')
    end
  end

  context '既存のラベルを更新するとき' do
    let!(:label) { create(:label, user_id: user.id) }
    it '加えた変更を更新すること' do
      visit edit_label_path(label.id)
      fill_in I18n.t('views.label.label.name'), with: label_name_edited
      click_button I18n.t('views.button.submit')
      expect(Label.exists?(name: label_name_edited)).to be true
      expect(page).to have_content label_name_edited
    end

    it '更新完了のフラッシュメッセージを表示すること' do
      visit edit_label_path(label.id)
      fill_in I18n.t('views.label.label.name'), with: label_name_edited
      click_button I18n.t('views.button.submit')
      expect(page).to have_content I18n.t('views.label.message.updated')
    end
  end

  context '既存のタスクを削除するとき' do
    let!(:label) { create(:label, user_id: user.id) }
    it 'ラベルを削除できること' do
      visit labels_path
      click_link I18n.t('views.label.link_text.delete')
      expect(Label.exists?(name: label.name)).not_to be true
      expect(page).not_to have_content label.name
    end

    it '削除完了のフラッシュメッセージを表示すること' do
      visit labels_path
      click_link I18n.t('views.label.link_text.delete')
      expect(page).to have_content I18n.t('views.label.message.deleted')
    end
  end
end
