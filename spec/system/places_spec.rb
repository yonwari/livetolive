require 'rails_helper'

describe 'ライブ会場管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:test_place) { FactoryBot.create(:place) }

  before do
    # ログイン
    visit new_user_session_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
    visit places_path
  end

  describe '一覧表示機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      it 'ライブ会場情報が表示される' do
        expect(page).to have_content 'テスト会場'
      end
    end

    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }

      it '管理画面に遷移できず、ライブ情報一覧リダイレクトされる' do
        expect(current_path).to eq(events_path)
      end
    end
  end


  describe '詳細表示機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      before do
        visit place_path(test_place)
      end

      it 'ライブ会場詳細が表示される' do
        expect(page).to have_content 'テスト会場'
        expect(page).to have_content '東京都練馬区下石神井'
        expect(page).to have_content '35'
        expect(page).to have_content '139'
      end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { admin_user }

    before do
      visit new_place_path
      fill_in '会場名', with: place_name
      fill_in '住所', with: address
      click_button '登録'
    end

    context '新規作成画面で会場名と住所を入力した時' do
      let(:place_name) { '新宿バティオス' }
      let(:address) { '東京都新宿区歌舞伎町２丁目４５−４' }

      it '正常に登録される' do
        expect(page).to have_content '新宿バティオス'
      end
    end

    context '新規作成画面で情報を入力しなかった時' do
      let(:place_name) { '' }
      let(:address) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '会場名を入力してください'
          expect(page).to have_content '住所を入力してください'
        end
      end
    end
  end




  describe '編集機能' do
    let(:login_user) { admin_user }

    before do
      visit edit_place_path( test_place )
      fill_in '会場名', with: place_name
      fill_in '住所', with: address
      click_button '更新'
    end

    context '編集画面で会場名と住所を入力した時' do
      let(:place_name) { '新宿バティオス' }
      let(:address) { '東京都新宿区歌舞伎町２丁目４５−４' }

      it '正常に登録される' do
        expect(page).to have_content '新宿バティオス'
      end
    end

    context '編集画面で情報を削除した時' do
      let(:place_name) { '' }
      let(:address) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '会場名を入力してください'
          expect(page).to have_content '住所を入力してください'
        end
      end
    end
  end
end