require 'rails_helper'

describe 'ユーザー機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user_2) }
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    # ログイン
    visit new_user_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  describe '一覧表示機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      it 'ユーザー一覧情報が表示される' do
        expect(page).to have_content 'ユーザー管理'
      end
    end

    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }

      it '管理画面に遷移できず、ライブ情報一覧にリダイレクトされる' do
        expect(current_path).to eq(events_path)
      end
    end
  end

  describe '詳細表示機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      before do
        visit user_path(user)
      end

      it 'マイページが表示される' do
        expect(page).to have_content user.user_name
      end
    end

    context '認証ユーザーでログインしている時' do
      let(:login_user) { user }

      before do
        visit user_path(user)
      end

      it 'マイページが表示される' do
        expect(page).to have_content user.user_name
      end
    end

    context '他ユーザーでログインしている時' do
      let(:login_user) { user_2 }

      before do
        visit user_path(user)
      end

      it 'ライブ情報一覧にリダイレクトされる' do
        expect(current_path).to eq(events_path)
      end
    end
  end


  describe '編集機能' do
    context '認証ユーザーでログインした時' do
      let(:login_user) { user }

      before do
        visit edit_user_path(user)
        fill_in 'ユーザー名', with: user_name
        fill_in 'メールアドレス', with: email
        click_button '更新'
      end

      context '編集画面でユーザー名とメールアドレスを入力した時' do
        let(:user_name) { 'hanako' }
        let(:email) { 'test3@example.com' }

        it '正常に登録される' do
          expect(page).to have_content '更新に成功しました'
          expect(page).to have_content 'hanako'
        end
      end

      context '編集画面で情報を削除した時' do
        let(:user_name) { '' }
        let(:email) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'ユーザー名を入力してください'
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end
      end
    end

    context '管理者ユーザーでログインした時' do
      let(:login_user) { admin_user }

      before do
        visit edit_user_path(user)
        fill_in 'ユーザー名', with: user_name
        fill_in 'メールアドレス', with: email
        click_button '更新'
      end

      context '編集画面でユーザー名とメールアドレスを入力した時' do
        let(:user_name) { 'hanako' }
        let(:email) { 'test3@example.com' }

        it '正常に登録される' do
          expect(page).to have_content '更新に成功しました'
          expect(page).to have_content 'hanako'
        end
      end

      context '編集画面で情報を削除した時' do
        let(:user_name) { '' }
        let(:email) { '' }

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'ユーザー名を入力してください'
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end
      end
    end

    context '他ユーザーでログインした時' do
      let(:login_user) { user_2 }

      before do
        visit edit_user_path(user)
      end

      it 'イベント一覧画面にリダイレクトされる' do
        expect(current_path).to eq(events_path)
      end
    end
  end
end