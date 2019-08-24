require 'rails_helper'

describe '記事投稿の管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      test_user = FactoryBot.create(:user, name: 'test_user1', email: 'test_user@example.com')
      FactoryBot.create(:post, title: 'specテスト投稿', user: test_user)
    end

    context 'test_userがログインしているとき' do
      before do
        visit login_path
        fill_in 'Email', with: 'test_user@example.com'
        fill_in 'Password', with: 'password'
        click_button 'ログインする'
      end

      it 'test_userが作成した投稿が表示されること' do
        expect(page).to have_content 'specテスト投稿'
      end
    end
  end
end