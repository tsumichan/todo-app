require 'rails_helper'

describe '管理画面' do
  describe '管理者ユーザー' do
    let!(:admin_user) { create(:admin) }
    let(:user_name) { 'user_name' }
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

    context '新規のユーザーを作成するとき' do
      it 'ユーザーを作成できること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.new')
        fill_in I18n.t('views.user.label.user_name'), with: user_name
        fill_in I18n.t('views.user.label.password'), with: 'password'
        select '管理者', from: I18n.t('views.user.label.role')
        click_button I18n.t('views.button.submit')
        expect(User.exists?(name: user_name)).to be true
        expect(page).to have_content user_name
      end

      it '作成完了のフラッシュメッセージを表示すること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.new')
        fill_in I18n.t('views.user.label.user_name'), with: user_name
        fill_in I18n.t('views.user.label.password'), with: 'password'
        select '管理者', from: I18n.t('views.user.label.role')
        click_button I18n.t('views.button.submit')
        expect(page).to have_content I18n.t('views.user.message.created')
      end
    end

    context 'ユーザーのロールを変更するとき' do
      let!(:user) { create(:user) }
      it 'ロールを変更できること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.edit'), href: edit_admin_user_path(user)
        select '一般', from: I18n.t('views.user.label.role')
        click_button I18n.t('views.button.submit')
        expect(User.find(user.id).role).to eq 'common'
        expect(page.find('tr', text: "#{user.name}")).to have_content I18n.t('enums.user.role.common')
      end

      it '変更完了のフラッシュメッセージを表示すること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.edit'), href: edit_admin_user_path(user)
        select '一般', from: I18n.t('views.user.label.role')
        click_button I18n.t('views.button.submit')
        expect(page).to have_content I18n.t('views.user.message.updated')
      end
    end

    context '既存のユーザーを削除するとき' do
      let!(:user) { create(:user) }
      it 'ユーザーを削除できること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.delete'), href: admin_user_path(user)
        expect(User.exists?(name: user.name)).not_to be true
        expect(page).not_to have_content user.name
      end

      it '削除完了のフラッシュメッセージを表示すること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.delete'), href: admin_user_path(user)
        expect(page).to have_content I18n.t('views.user.message.deleted')
      end

      it '削除されたユーザーが持つタスクも削除されること' do
        visit admin_users_path
        click_link I18n.t('views.user.link_text.delete'), href: admin_user_path(user)
        expect(Task.exists?(user_id: user.id)).not_to be true
      end
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
      visit admin_users_path
      expect(page).not_to have_content 'ユーザー 一覧'
    end
  end
end
