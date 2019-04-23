require 'rails_helper'

describe 'イベント機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  place = FactoryBot.build(:place)
  event = FactoryBot.create(:event)

  describe '一覧表示機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }
      before do
        # ログイン
        visit new_user_session_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログイン'
        visit events_path
      end
      it 'ライブ会場情報が表示される' do
        expect(page).to have_content 'ライブ情報一覧'
        expect(page).to have_content 'テストライブ'
      end
    end
    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }
      before do
        # ログイン
        visit new_user_session_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログイン'
        visit events_path
      end
      it 'ライブ会場情報が表示される' do
        expect(page).to have_content 'ライブ情報一覧'
        expect(page).to have_content 'テストライブ'
      end
    end
    context '未ログインの時' do
      before do
        visit events_path
      end
      it 'ライブ会場情報が表示される' do
        expect(page).to have_content 'ライブ情報一覧'
        expect(page).to have_content 'テストライブ'
      end
    end
  end

  describe '詳細機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }
      before do
        # ログイン
        visit new_user_session_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログイン'
        visit event_path(event)
      end
      it 'イベント情報詳細が表示される' do
        expect(page).to have_content 'テストライブ'
        expect(page).to have_content '#test'
        expect(page).to have_content '#test2'
      end
    end
    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }
      before do
        # ログイン
        visit new_user_session_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログイン'
        visit event_path(event)
      end
      it 'イベント情報詳細が表示される' do
        expect(page).to have_content 'テストライブ'
        expect(page).to have_content '#test'
        expect(page).to have_content '#test2'
      end
    end
    context '未ログインの時' do
      before do
        visit event_path(event)
      end
      it 'イベント情報詳細が表示される' do
        expect(page).to have_content 'テストライブ'
        expect(page).to have_content '#test'
        expect(page).to have_content '#test2'
      end
    end
  end


  describe '詳細表示機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      before do
        visit event_path(event)
      end

      it 'ライブ会場詳細が表示される' do
        expect(page).to have_content 'テストライブ'
        expect(page).to have_content '#test'
        expect(page).to have_content '#test2'
      end
    end
    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }

      before do
        visit event_path(event)
      end

      it 'ライブ会場詳細が表示される' do
        expect(page).to have_content 'テストライブ'
        expect(page).to have_content '#test'
        expect(page).to have_content '#test2'
      end
    end
    context '未ログインの時' do

      before do
        visit event_path(event)
      end

      it 'ライブ会場詳細が表示される' do
        expect(page).to have_content 'テストライブ'
        expect(page).to have_content '#test'
        expect(page).to have_content '#test2'
      end
    end
  end

  describe '新規作成機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      before do
        visit new_event_path
        fill_in 'ライブ名', with: event_name
        fill_in 'open_date_form', with: open_date
        fill_in 'start_date_form', with: start_date
        fill_in 'end_date_form', with: end_date
        fill_in 'event_comedianlist', with: comedianlist
        fill_in 'text_count', with: explanation
        fill_in '予約URL', with: reserve_url
        click_button '決定'
      end

      context '新規作成画面で情報を入力しなかった時' do
        let(:event_name) { "" }
        let(:start_date) { "" }
        let(:open_date) { "" }
        let(:end_date) { "" }
        let(:place_id) {  }
        let(:explanation) { "" }
        let(:reserve_url) { ""}
        let(:comedianlist) { "" }

        it 'エラーとなる' do
          expect(current_path).to eq(new_event_path)
          message = page.find('#event_event_title').native.attribute('validationMessage')
          expect(message).not_to be_empty
        end
      end

      context '新規作成画面で全ての情報を入力した時' do
        let(:event_name) { "テストライブ" }
        let(:start_date) { DateTime.now.since(100) }
        let(:open_date) { DateTime.now.since(100) }
        let(:end_date) { DateTime.now.since(100) }
        let(:explanation) { "test" }
        let(:reserve_url) { "https://www.yahoo.co.jp/"}
        let(:comedianlist) { "#test #test2" }

        it '正常に登録される' do
          expect(page).to have_content 'テストライブ'
        end
      end
    end

    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }

      before do
        visit new_event_path
        fill_in 'ライブ名', with: event_name
        fill_in 'open_date_form', with: open_date
        fill_in 'start_date_form', with: start_date
        fill_in 'end_date_form', with: end_date
        fill_in 'event_comedianlist', with: comedianlist
        fill_in 'text_count', with: explanation
        fill_in '予約URL', with: reserve_url
        click_button '決定'
      end

      context '新規作成画面で情報を入力しなかった時' do
        let(:event_name) { "" }
        let(:start_date) { "" }
        let(:open_date) { "" }
        let(:end_date) { "" }
        let(:place_id) {  }
        let(:explanation) { "" }
        let(:reserve_url) { ""}
        let(:comedianlist) { "" }

        it 'エラーとなる' do
          expect(current_path).to eq(new_event_path)
          message = page.find('#event_event_title').native.attribute('validationMessage')
          expect(message).not_to be_empty
        end
      end

      context '新規作成画面で全ての情報を入力した時' do
        let(:event_name) { "テストライブ" }
        let(:start_date) { DateTime.now.since(100) }
        let(:open_date) { DateTime.now.since(100) }
        let(:end_date) { DateTime.now.since(100) }
        let(:explanation) { "test" }
        let(:reserve_url) { "https://www.yahoo.co.jp/"}
        let(:comedianlist) { "#test #test2" }

        it '正常に登録される' do
          expect(page).to have_content 'テストライブ'
        end
      end
    end

    context '未ログインの時' do

      before do
        visit new_event_path
        fill_in 'ライブ名', with: event_name
        fill_in 'open_date_form', with: open_date
        fill_in 'start_date_form', with: start_date
        fill_in 'end_date_form', with: end_date
        fill_in 'event_comedianlist', with: comedianlist
        fill_in 'text_count', with: explanation
        fill_in '予約URL', with: reserve_url
        click_button '決定'
      end

      context '新規作成画面で情報を入力しなかった時' do
        let(:event_name) { "" }
        let(:start_date) { "" }
        let(:open_date) { "" }
        let(:end_date) { "" }
        let(:explanation) { "" }
        let(:reserve_url) { ""}
        let(:comedianlist) { "" }

        it 'エラーとなる' do
          expect(current_path).to eq(new_event_path)
          message = page.find('#event_event_title').native.attribute('validationMessage')
          expect(message).not_to be_empty
        end
      end

      context '新規作成画面で全ての情報を入力した時' do
        let(:event_name) { "テストライブ" }
        let(:start_date) { DateTime.now.since(9999999) }
        let(:open_date) { DateTime.now.since(999999) }
        let(:end_date) { DateTime.now.since(99999999) }
        let(:explanation) { "test" }
        let(:reserve_url) { "https://www.yahoo.co.jp/"}
        let(:comedianlist) { "#test #test2" }

        it '正常に登録される' do
          expect(page).to have_content 'テストライブ'
        end
      end
    end
  end

  describe '編集機能' do
    context '管理者でログインしている時' do
      let(:login_user) { admin_user }

      before do
        visit edit_event_path(event)
        fill_in 'ライブ名', with: event_name
        fill_in 'open_date_form', with: open_date
        fill_in 'start_date_form', with: start_date
        fill_in 'end_date_form', with: end_date
        fill_in 'event_comedianlist', with: comedianlist
        fill_in 'text_count', with: explanation
        fill_in '予約URL', with: reserve_url
        click_button '決定'
      end

      context '編集画面で情報を入力しなかった時' do
        let(:event_name) { "" }
        let(:start_date) { "" }
        let(:open_date) { "" }
        let(:end_date) { "" }
        let(:place_id) {  }
        let(:explanation) { "" }
        let(:reserve_url) { ""}
        let(:comedianlist) { "" }

        it 'エラーとなる' do
          expect(current_path).to eq(edit_event_path(event))
          message = page.find('#event_event_title').native.attribute('validationMessage')
          expect(message).not_to be_empty
        end
      end

      context '編集画面で全ての情報を入力した時' do
        let(:event_name) { "テストライブ" }
        let(:start_date) { DateTime.now }
        let(:open_date) { DateTime.now }
        let(:end_date) { DateTime.now }
        let(:explanation) { "test" }
        let(:reserve_url) { "https://www.yahoo.co.jp/"}
        let(:comedianlist) { "#test #test2" }

        it '正常に登録される' do
          expect(current_path).to eq(edit_event_path(event))
        end
      end
    end

    context '一般ユーザーでログインしている時' do
      let(:login_user) { user }

      before do
        visit edit_event_path(event)
        fill_in 'ライブ名', with: event_name
        fill_in 'open_date_form', with: open_date
        fill_in 'start_date_form', with: start_date
        fill_in 'end_date_form', with: end_date
        fill_in 'event_comedianlist', with: comedianlist
        fill_in 'text_count', with: explanation
        fill_in '予約URL', with: reserve_url
        click_button '決定'
      end

      context '編集画面で情報を入力しなかった時' do
        let(:event_name) { "" }
        let(:start_date) { "" }
        let(:open_date) { "" }
        let(:end_date) { "" }
        let(:place_id) {  }
        let(:explanation) { "" }
        let(:reserve_url) { ""}
        let(:comedianlist) { "" }

        it 'エラーとなる' do
          expect(current_path).to eq(edit_event_path(event))
          message = page.find('#event_event_title').native.attribute('validationMessage')
          expect(message).not_to be_empty
        end
      end

      context '編集画面で全ての情報を入力した時' do
        let(:event_name) { "テストライブ" }
        let(:start_date) { DateTime.now }
        let(:open_date) { DateTime.now }
        let(:end_date) { DateTime.now }
        let(:explanation) { "test" }
        let(:reserve_url) { "https://www.yahoo.co.jp/"}
        let(:comedianlist) { "#test #test2" }

        it '正常に登録される' do
          expect(current_path).to eq(edit_event_path(event))
        end
      end
    end

    context '未ログインの時' do

      before do
        visit edit_event_path(event)
        fill_in 'ライブ名', with: event_name
        fill_in 'open_date_form', with: open_date
        fill_in 'start_date_form', with: start_date
        fill_in 'end_date_form', with: end_date
        fill_in 'event_comedianlist', with: comedianlist
        fill_in 'text_count', with: explanation
        fill_in '予約URL', with: reserve_url
        click_button '決定'
      end

      context '編集画面で情報を入力しなかった時' do
        let(:event_name) { "" }
        let(:start_date) { "" }
        let(:open_date) { "" }
        let(:end_date) { "" }
        let(:explanation) { "" }
        let(:reserve_url) { ""}
        let(:comedianlist) { "" }

        it 'エラーとなる' do
          expect(current_path).to eq(edit_event_path(event))
          message = page.find('#event_event_title').native.attribute('validationMessage')
          expect(message).not_to be_empty
        end
      end

      context '編集画面で全ての情報を入力した時' do
        let(:event_name) { "テストライブ" }
        let(:start_date) { DateTime.now }
        let(:open_date) { DateTime.now }
        let(:end_date) { DateTime.now }
        let(:explanation) { "test" }
        let(:reserve_url) { "https://www.yahoo.co.jp/"}
        let(:comedianlist) { "#test #test2" }

        it '正常に登録される' do
          expect(current_path).to eq(edit_event_path(event))
        end
      end
    end
  end
end
