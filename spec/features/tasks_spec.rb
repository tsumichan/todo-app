require 'rails_helper'

describe 'タスク' do
  let(:title) { 'テスト用タスク' }
  let(:title_edited) { '変更用タスク' }
  let(:test_title) { 'テスト' }


  context '新規のタスクを作成する' do
    it '作成する' do
      visit new_task_path
      fill_in I18n.t('view.task.label.title'), with: title
      fill_in I18n.t('view.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('view.task.label.due_at'), with: '2020-01-01 00:00:00'
      fill_in I18n.t('view.task.label.status'), with: 'waiting'
      fill_in I18n.t('view.task.label.priority'), with: '1'
      click_button I18n.t('view.task.button.submit')
      expect(Task.exists?(title: title)).to be true
      expect(page).to have_content title
    end

    it '作成完了のフラッシュメッセージを表示する' do
      visit new_task_path
      fill_in I18n.t('view.task.label.title'), with: title
      fill_in I18n.t('view.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('view.task.label.due_at'), with: '2020-01-01 00:00:00'
      fill_in I18n.t('view.task.label.status'), with: 'waiting'
      fill_in I18n.t('view.task.label.priority'), with: '1'
      click_button I18n.t('view.task.button.submit')
      expect(page).to have_content I18n.t('view.task.message.created')
    end
  end

  context '既存のタスクを更新する' do
    let(:task) { create(:task) }
    it '変更する' do
      visit edit_task_path(task.id)
      fill_in I18n.t('view.task.label.title'), with: title_edited
      click_button I18n.t('view.task.button.submit')
      expect(Task.exists?(title: title_edited)).to be true
      expect(page).to have_content title_edited
    end

    it '更新完了のフラッシュメッセージを表示する' do
      visit edit_task_path(task.id)
      fill_in I18n.t('view.task.label.title'), with: '変更タスク'
      click_button I18n.t('view.task.button.submit')
      expect(page).to have_content I18n.t('view.task.message.updated')
    end
  end

  context '既存のタスクを削除する' do
    let!(:task) { create(:task) }
    it '削除する' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.delete')
      expect(Task.exists?(title: title)).not_to be true
      expect(page).not_to have_content title
    end

    it '削除完了のフラッシュメッセージを表示する' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.delete')
      expect(page).to have_content I18n.t('view.task.message.deleted')
    end
  end

  context 'タスクを作成日時の降順で表示する' do
    let! (:new_task) { create(:new_task) }
    let! (:old_task) { create(:old_task) }
    it 'タスクを降順でソートする' do
      visit tasks_path
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(new_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(old_task.id))
    end
  end

  context 'タスクを終了期限の近い順で表示する' do
    let! (:new_task) { create(:new_task, due_at: '2020-01-01') }
    let! (:old_task) { create(:old_task, due_at: '2000-01-01') }
    it '終了期限順でソートする' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.sort_by_due_at')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(old_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(new_task.id))
    end
  end

  context 'タスクを作成日時が新しい順でソートする' do
    it '作成日時順でソートするリンクがある' do
      visit tasks_path
      expect(page).to have_content I18n.t('view.task.link_text.sort_by_created_at')
    end

    it 'リンクにパラメータがついていない' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.sort_by_created_at')
      expect(current_path).to eq ('/tasks')
    end
  end

  context 'タスクを検索する' do
    let!(:task) { create(:task) }
    let!(:working_task) { create_list(:working_task, 3)}
    it '入力された文字列で検索をする' do
      visit tasks_path
      fill_in :search, with: test_title
      click_button I18n.t('view.task.button.search')
      expect(page).to have_content test_title
    end

    it 'マッチするものがない場合、マッチするものがなかったことを知らせる' do
      visit tasks_path
      fill_in :search, with: 'サンプル'
      click_button I18n.t('view.task.button.search')
      expect(page).to have_content I18n.t('view.task.message.no_match_task')
    end

    it 'ステータスで検索する' do
      visit tasks_path
      select 'working', from: 'status'
      click_button I18n.t('view.task.button.search')
      searched_task = Task.search_status('working')
      expect(page.all('tbody tr').count).to eq searched_task.count
    end

    it 'タイトルとステータスで検索する' do
      visit tasks_path
      fill_in 'search', with: test_title
      select 'working', from: 'status'
      click_button I18n.t('view.task.button.search')
      searched_task = Task.search(test_title).search_status('working')
      expect(page.all('tbody tr').count).to eq searched_task.count
    end
  end
end
