require 'rails_helper'

describe 'タスク' do
  context '新規のタスクを作成する' do
    it '作成する' do
      visit '/tasks/new'
      fill_in 'タスク名', with: '新規タスク1'
      fill_in 'タスクの説明', with: '新規タスク1です'
      fill_in '期限', with: '2020-01-01 00:00:00'
      fill_in 'ステータス', with: '1'
      fill_in '優先度', with: '1'
      click_button '登録'
      expect(page).to have_content '新規タスク1'
    end

    it '作成完了のフラッシュメッセージが表示される' do
      visit '/tasks/new'
      fill_in 'タスク名', with: '新規タスク2'
      fill_in 'タスクの説明', with: '新規タスク2です'
      fill_in '期限', with: '2020-01-01 00:00:00'
      fill_in 'ステータス', with: '1'
      fill_in '優先度', with: '1'
      click_button '登録'
      expect(page).to have_content 'タスクを追加しました'
    end
  end

  context '既存のタスクを更新する' do
    let(:task) { create(:task) }
    it '変更する' do
      visit edit_task_path(task.id)
      fill_in 'タスク名', with: '変更タスク1'
      click_button '登録'
      expect(page).to have_content '変更タスク1'
    end

    it '更新完了のフラッシュメッセージが表示される' do
      visit edit_task_path(task.id)
      fill_in 'タスク名', with: '変更タスク2'
      click_button '登録'
      expect(page).to have_content 'タスクを更新しました'
    end
  end

  context '既存のタスクを削除する' do
    let!(:task) { create(:task) }
    it '削除する' do
      visit '/tasks'
      click_link '削除'
      expect(page).not_to have_content 'テスト用タスク'
    end

    it '削除完了のフラッシュメッセージが表示される' do
      visit '/tasks'
      click_link '削除'
      expect(page).to have_content 'タスクを削除しました'
    end
  end
end
