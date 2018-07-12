require 'rails_helper'

describe 'タスク' do
  let(:title) { 'テスト用タスク' }
  let(:title_edited) { '変更用タスク' }

  context '新規のタスクを作成する' do
    it '作成する' do
      visit new_task_path
      fill_in I18n.t('view.task.label.title'), with: title
      fill_in I18n.t('view.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('view.task.label.due_at'), with: '2020-01-01 00:00:00'
      fill_in I18n.t('view.task.label.status'), with: '1'
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
      fill_in I18n.t('view.task.label.status'), with: '1'
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
    let! (:new_task) { create(:task, created_at: '2020-01-01') }
    let! (:old_task) { create(:task, created_at: '2000-01-01') }
    it 'タスクを降順でソートする' do
      visit tasks_path
      expect(page.all('tr')[1]).to have_link('編集', href: edit_task_path(new_task.id))
      expect(page.all('tr')[2]).to have_link('編集', href: edit_task_path(old_task.id))
    end
  end

  context 'タスクを終了期限の近い順で表示する' do
    let! (:new_task) { create(:task, due_at: '2020-01-01') }
    let! (:old_task) { create(:task, due_at: '2000-01-01') }
    it '終了期限順でソートする' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.sort_by_due_at')
      expect(page.all('tr')[1]).to have_link('編集', href: edit_task_path(old_task.id))
      expect(page.all('tr')[2]).to have_link('編集', href: edit_task_path(new_task.id))
    end
  end
end
