require 'rails_helper'
require 'kaminari'

describe 'タスク' do
  let(:title) { 'テスト用タスク' }
  let(:title_edited) { '変更用タスク' }
  let(:test_title) { 'テスト' }
  let!(:user) { create(:user) }
  before do
    visit '/login'
    fill_in I18n.t('views.user.label.user_name'), with: user.name
    fill_in I18n.t('views.user.label.password'), with: 'password'
    click_button I18n.t('views.user.button.log_in')
  end

  context '新規のタスクを作成するとき' do
    it 'タスクが作成できること' do
      visit new_task_path
      fill_in I18n.t('views.task.label.title'), with: title
      fill_in I18n.t('views.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('views.task.label.due_at'), with: '2020/01/01 00:00'
      select '完了', from: I18n.t('views.task.label.status')
      select '', from: I18n.t('views.task.label.priority')
      click_button I18n.t('views.button.submit')
      expect(Task.exists?(user_id: user.id)).to be true
      expect(page).to have_content title
    end

    it '作成完了のフラッシュメッセージを表示すること' do
      visit new_task_path
      fill_in I18n.t('views.task.label.title'), with: title
      fill_in I18n.t('views.task.label.description'), with: 'テスト用タスクです'
      fill_in I18n.t('views.task.label.due_at'), with: '2020/01/01 00:00'
      select '完了', from: I18n.t('views.task.label.status')
      select '', from: I18n.t('views.task.label.priority')
      click_button I18n.t('views.button.submit')
      expect(page).to have_content I18n.t('views.task.message.created')
    end
  end

  context '既存のタスクを更新するとき' do
    let(:task) { create(:task, user_id: user.id) }
    it '加えた変更を更新すること' do
      visit edit_task_path(task.id)
      fill_in I18n.t('views.task.label.title'), with: title_edited
      click_button I18n.t('views.button.submit')
      expect(Task.exists?(user_id: user.id, title: title_edited)).to be true
      expect(page).to have_content title_edited
    end

    it '更新完了のフラッシュメッセージを表示すること' do
      visit edit_task_path(task.id)
      fill_in I18n.t('views.task.label.title'), with: '変更タスク'
      click_button I18n.t('views.button.submit')
      expect(page).to have_content I18n.t('views.task.message.updated')
    end
  end

  context '既存のタスクを削除するとき' do
    let!(:task) { create(:task, user_id: user.id) }
    it 'タスクを削除できること' do
      visit tasks_path
      click_link I18n.t('views.task.link_text.delete')
      expect(Task.exists?(user_id: user.id)).not_to be true
      expect(page).not_to have_content title
    end

    it '削除完了のフラッシュメッセージを表示すること' do
      visit tasks_path
      click_link I18n.t('views.task.link_text.delete')
      expect(page).to have_content I18n.t('views.task.message.deleted')
    end
  end

  context 'タスクを作成日時の降順で表示するとき' do
    let! (:new_task) { create(:new_task, user_id: user.id) }
    let! (:old_task) { create(:old_task, user_id: user.id) }
    it 'タスクを降順でソートすること' do
      visit tasks_path
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(new_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(old_task.id))
    end
  end

  context '終了期限でソートするとき' do
    let! (:approaching_task) { create(:task, user_id: user.id) }
    let! (:not_approaching_task) { create(:task, due_at: approaching_task.due_at + 1.day, user_id: user.id) }
    it '終了期限が近いタスクが上に来ること' do
      visit tasks_path
      select I18n.t('views.task.sort.due_at'), from: 'sort'
      click_button I18n.t('views.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(approaching_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(not_approaching_task.id))
    end
  end

  context '作成日時でソートするとき' do
    let! (:new_task) { create(:new_task, user_id: user.id) }
    let! (:old_task) { create(:old_task, user_id: user.id) }
    it '作成日時が新しいタスクが上に来ること' do
      visit tasks_path
      select I18n.t('views.task.sort.created_at'), from: 'sort'
      click_button I18n.t('views.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(new_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(old_task.id))
    end
  end

  context '優先度でソートするとき' do
    let! (:high_priority_task) { create(:high_priority_task, user_id: user.id) }
    let! (:low_priority_task) { create(:low_priority_task, user_id: user.id) }
    it '優先順が高いタスクが上に来ること' do
      visit tasks_path
      select I18n.t('views.task.sort.priority_desc'), from: 'sort'
      click_button I18n.t('views.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(high_priority_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(low_priority_task.id))
    end

    it '優先順が低いタスクが上に来ること' do
      visit tasks_path
      select I18n.t('views.task.sort.priority_asc'), from: 'sort'
      click_button I18n.t('views.button.search')
      expect(page.all('tbody tr')[0]).to have_link('編集', href: edit_task_path(low_priority_task.id))
      expect(page.all('tbody tr')[1]).to have_link('編集', href: edit_task_path(high_priority_task.id))
    end
  end

  context 'タスクをタイトルで検索するとき' do
    let!(:task) { create(:task, user_id: user.id) }
    it '入力された文字列でタスクを検索できること' do
      visit tasks_path
      fill_in :search, with: test_title
      click_button I18n.t('views.button.search')
      expect(page).to have_content test_title
    end

    it 'マッチするものがない場合、マッチするものがなかったことを知らせること' do
      visit tasks_path
      fill_in :search, with: 'サンプル'
      click_button I18n.t('views.button.search')
      expect(page).to have_content I18n.t('views.task.message.no_match_task')
    end
  end

  context 'タスクをステータスで検索するとき' do
    it '指定したステータスを持つタスクを検索すること' do
      visit tasks_path
      select I18n.t('enums.task.status.doing'), from: 'status'
      click_button I18n.t('views.button.search')
      searched_task = Task.search_by_status('doing')
      expect(page.all('tbody tr').count).to eq searched_task.count
    end
  end

  context 'タスクをラベルで検索するとき' do
    before do
      has_labels_task = create(:task, user_id: user.id)
      labels = create_list(:label, 2, tasks:[has_labels_task], user_id: user.id)
    end
    it '指定したラベルを持つタスクを検索すること' do
      visit tasks_path
      check 'label_ids_', match: :first
      searched_task = Task.search_by_labels(user.tasks.first.labels)
      expect(page.all('tbody tr').count).to eq searched_task.count
    end
  end

  context 'タイトルとステータスで検索するとき' do
    it '指定したタイトルとステータスを持つタスクを検索すること' do
      visit tasks_path
      fill_in 'search', with: test_title
      select I18n.t('enums.task.status.doing'), from: 'status'
      click_button I18n.t('views.button.search')
      searched_task = Task.search_by_title(test_title).search_by_status('doing')
      expect(page.all('tbody tr').count).to eq searched_task.count
    end
  end

  context 'タスクが16件以上あるとき' do
    let!(:tasks) { create_list(:task, 50, user_id: user.id) }
    it 'ページネーションが表示されること' do
      visit tasks_path
      expect(page.all('nav ul')[1]).to have_link('2', href: '/?page=2')
    end

    it '1ページあたり15件のタスクが表示されること' do
      visit tasks_path
      expect(page.all('tbody tr').count).to eq Kaminari.config.default_per_page
    end
  end
end
