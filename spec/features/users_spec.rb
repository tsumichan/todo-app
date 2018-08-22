require 'rails_helper'

describe '管理画面' do
  describe '管理者ユーザー' do
    let!(:admin_user) { create(:admin) }
    before do
      visit login_path
      fill_in I18n.t('views.user.label.user_name'), with: admin_user.name
      fill_in I18n.t('views.user.label.password'), with: 'password'
      click_button I18n.t('views.user.button.log_in')
    end

    it '管理画面のリンクが見えるようになっていること' do
      expect(page).to have_content I18n.t('views.header.link.admin_page')
    end

    it 'ユーザー 一覧ページにアクセスできること' do
      expect(page).to have_content I18n.t('views.header.link.admin_page')
      click_link I18n.t('views.header.link.admin_page')
      expect(page).to have_content 'ユーザー 一覧'
    end
  end

  describe '一般ユーザー' do
    let!(:common_user) { create(:common_user) }
    before do
      visit login_path
      fill_in I18n.t('views.user.label.user_name'), with: common_user.name
      fill_in I18n.t('views.user.label.password'), with: 'password'
      click_button I18n.t('views.user.button.log_in')
    end

    it '管理画面のリンクが見えないようになっていること' do
      expect(page).not_to have_content I18n.t('views.header.link.admin_page')
    end

    it 'ユーザー 一覧ページにアクセスできないこと' do
      visit admin_path
      expect(page).not_to have_content 'ユーザー 一覧'
    end
  end
end
