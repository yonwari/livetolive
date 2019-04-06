require 'rails_helper'

describe 'ライブ会場管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # adminユーザー、会場情報作成
      user_admin = FactoryBot.create(:admin_user) 
      user_a = FactoryBot.create(:user)
      FactoryBot.create(:place)
    end

    context '管理者でログインしている時' do
      before do
        # 管理者でログイン
        visit new_user_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: 'password'
        click_button 'Sign in'
        # ライブ会場管理画面に遷移
        visit places_path
      end

      it 'ライブ会場情報が表示される' do
        expect(page).to have_content 'テスト会場'
      end
    end

    context '一般ユーザーでログインしている時' do
      before do
        visit new_user_session_path
        fill_in 'Email', with: 'test1@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Sign in'
        visit places_path
      end

      it '管理画面に遷移できず、ライブ情報一覧リダイレクトされる' do
        expect(page).to have_no_content 'テスト会場'
      end
    end
  end
end