require 'rails_helper'

describe 'ライブ会場管理機能', type: :system do
  let(:user) { FactoryBot.create(:user)}
  let(:admin_user) { FactoryBot.create(:admin_user)}
  FactoryBot.create(:place)

  before do
    # ログイン
    visit new_user_session_path
    fill_in 'Email', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button 'Sign in'
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
        expect(page).to have_no_content 'テスト会場'
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

    context '新規作成画面で会場名と住所を入力しなかった時' do
      let(:place_name) { '' }
      let(:address) { '' }

      it 'エラーとなる' do
        # within '#error_explanation' do
          expect(page).to have_content 'error'
        # end
      end
    end
  end


end