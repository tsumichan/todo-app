require 'rails_helper'

describe 'タスク' do
  before do
    @task = Task.create(
      title: 'テスト用タスク', description: 'テスト用タスクです',
      due_at: '2020-01-01 00:00:00', status:1, priority: 1
    )
  end

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

  context '既存のタスクを更新する' do
    it '作成完了のフラッシュメッセージが表示される' do
      visit edit_task_path(@task)
      fill_in 'タスク名', with: '変更タスク'
      click_button '登録'
      expect(page).to have_content 'タスクを更新しました'
    end
  end
end
