require 'rails_helper'

describe 'タスク' do
  context '新規のタスクを作成する' do
    it '作成完了のフラッシュメッセージが表示される' do
      visit 'tasks/new'
      fill_in 'タスク名', with: '新規タスク'
      fill_in 'タスクの説明', with: '新規タスクです'
      fill_in '期限', with: '2020-01-01 00:00:00'
      fill_in 'ステータス', with: '1'
      fill_in '優先度', with: '1'
      click_button '登録'
      expect(page).to have_content 'タスクを追加しました'
    end
  end
end
