require 'rails_helper'

describe 'タスク' do
  let(:title) { 'テスト用タスク' }
  let(:title_edited) { '変更用タスク' }
  let(:test_title) { 'テスト' }

  context '新規のタスクを作成するとき' do
    it 'タスクが作成できること' do
      visit new_task_path
      fill_in I18n.t('view.task.label.title'), with: title
      fill_in I18n.t('view.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('view.task.label.due_at'), with: '2020-01-01 00:00:00'
      fill_in I18n.t('view.task.label.status'), with: 'todo'
      fill_in I18n.t('view.task.label.priority'), with: 'nothing'
      click_button I18n.t('view.task.button.submit')
      expect(Task.exists?(title: title)).to be true
      expect(page).to have_content title
    end

    it '作成完了のフラッシュメッセージを表示すること' do
      visit new_task_path
      fill_in I18n.t('view.task.label.title'), with: title
      fill_in I18n.t('view.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('view.task.label.due_at'), with: '2020-01-01 00:00:00'
      fill_in I18n.t('view.task.label.status'), with: 'todo'
      fill_in I18n.t('view.task.label.priority'), with: 'nothing'
      click_button I18n.t('view.task.button.submit')
      expect(page).to have_content I18n.t('view.task.message.created')
    end
  end

  context '既存のタスクを更新するとき' do
    let(:task) { create(:task) }
    it '加えた変更を更新すること' do
      visit edit_task_path(task.id)
      fill_in I18n.t('view.task.label.title'), with: title_edited
      click_button I18n.t('view.task.button.submit')
      expect(Task.exists?(title: title_edited)).to be true
      expect(page).to have_content title_edited
    end

    it '更新完了のフラッシュメッセージを表示すること' do
      visit edit_task_path(task.id)
      fill_in I18n.t('view.task.label.title'), with: '変更タスク'
      click_button I18n.t('view.task.button.submit')
      expect(page).to have_content I18n.t('view.task.message.updated')
    end
  end

  context '既存のタスクを削除するとき' do
    let!(:task) { create(:task) }
    it 'タスクを削除できること' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.delete')
      expect(Task.exists?(title: title)).not_to be true
      expect(page).not_to have_content title
    end

    it '削除完了のフラッシュメッセージを表示すること' do
      visit tasks_path
      click_link I18n.t('view.task.link_text.delete')
      expect(page).to have_content I18n.t('view.task.message.deleted')
    end
  end

  context 'タスクを作成日時の降順で表示するとき' do
    let! (:new_task) { create(:new_task) }
    let! (:old_task) { create(:old_task) }
    it 'タスクを降順でソートすること' do
      visit tasks_path
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(new_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(old_task.id))
    end
  end

  context '終了期限でソートするとき' do
    let! (:approaching_task) { create(:approaching_task) }
    let! (:not_approaching_task) { create(:not_approaching_task) }
    it '終了期限が近い順タスクが上に来ること' do
      visit tasks_path
      select I18n.t('view.task.sort.due_at'), from: 'sort'
      click_button I18n.t('view.task.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(approaching_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(not_approaching_task.id))
    end
  end

  context '作成日時でソートするとき' do
    let! (:new_task) { create(:new_task) }
    let! (:old_task) { create(:old_task) }
    it '作成日時が新しい順タスクが上に来ること' do
      visit tasks_path
      select I18n.t('view.task.sort.created_at'), from: 'sort'
      click_button I18n.t('view.task.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(new_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(old_task.id))
    end
  end

  context '優先度でソートするとき' do
    let! (:high_priority_task) { create(:high_priority_task) }
    let! (:low_priority_task) { create(:low_priority_task) }
    it '優先順が高い順タスクが上に来ること' do
      visit tasks_path
      select I18n.t('view.task.sort.priority_desc'), from: 'sort'
      click_button I18n.t('view.task.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(high_priority_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(low_priority_task.id))
    end

    it '優先順が低い順タスクが上に来ること' do
      visit tasks_path
      select I18n.t('view.task.sort.priority_asc'), from: 'sort'
      click_button I18n.t('view.task.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(low_priority_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(high_priority_task.id))
    end
  end

  context 'タスクをタイトルで検索するとき' do
    let!(:task) { create(:task) }
    it '入力された文字列でタスクを検索できること' do
      visit tasks_path
      fill_in :search, with: test_title
      click_button I18n.t('view.task.button.search')
      expect(page).to have_content test_title
    end

    it 'マッチするものがない場合、マッチするものがなかったことを知らせること' do
      visit tasks_path
      fill_in :search, with: 'サンプル'
      click_button I18n.t('view.task.button.search')
      expect(page).to have_content I18n.t('view.task.message.no_match_task')
    end
  end

  context 'タスクをステータスで検索するとき' do
    it '指定したステータスを持つタスクを検索すること' do
      visit tasks_path
      select I18n.t('enums.task.status.doing'), from: 'status'
      click_button I18n.t('view.task.button.search')
      searched_task = Task.search_by_status('doing')
      expect(page.all('tbody tr').count).to eq searched_task.count
    end
  end

  context 'タイトルとステータスで検索するとき' do
    it '指定したタイトルとステータスを持つタスクを検索すること' do
      visit tasks_path
      fill_in 'search', with: test_title
      select I18n.t('enums.task.status.doing'), from: 'status'
      click_button I18n.t('view.task.button.search')
      searched_task = Task.search_by_title(test_title).search_by_status('doing')
      expect(page.all('tbody tr').count).to eq searched_task.count
    end
  end
end
