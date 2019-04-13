require 'rails_helper'

describe 'マイページ機能', type: :system do
  place = FactoryBot.create(:place)
  shibuya = FactoryBot.create(:shibuya)
  today_event = FactoryBot.create(:event)
  tomorrow_event = FactoryBot.create(:tomorrow_event)
  nextmonth_event = FactoryBot.create(:nm_event)

  let(:user) { FactoryBot.create(:user) }


  context "ログインしている時" do
    before do
      # ログイン
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end
    let(:login_user) { user }

    context "お気に入り登録をした時" do
      before do
        visit event_path(today_event)
        click_link "favorite"
        visit user_path(user)
      end
      it "マイページにお気に入り登録したイベントが表示される" do
        expect(page).to have_content "テストライブ"
      end
    end

    context "カレンダー登録をした時" do
      context "本日分のライブの時" do
        before do
          visit event_path(today_event)
          click_link "calendaradd"
        end
        it "本日の予定欄にライブが追加される" do
          expect(page).to have_content "テストライブ"
          expect(page).to have_content "テスト会場"
          expect(page).to have_content "経路を調べる"
        end
      end
      context "明日分のライブの時" do
        before do
          visit event_path(tomorrow_event)
          click_link "calendaradd"
        end
        it "カレンダーのみにライブが追加される" do
          expect(page).to have_content "明日用ライブ"
          expect(page).not_to have_content "渋谷会場"
        end
      end

      context "来月のライブの時" do
        before do
          visit event_path(nextmonth_event)
          click_link "calendaradd"
        end
        context "1ページ目の時" do
          it "カレンダー1ページ目にはライブが見えない" do
            expect(page).not_to have_content "来月用ライブ"
          end
        end
        context "2ページ目の時" do
          before do
            click_button "次月"
          end
          it "ライブが登録されている" do
            expect(page).to have_content "来月用ライブ"
          end
        end
      end
    end
  end

  context "未ログインの時" do
    before do
      visit event_path(today_event)
    end
    it "お気に入り登録ボタンがない" do
      expect(page).not_to have_link 'favorite'
    end
    it "カレンダー登録ボタンがない" do
      expect(page).not_to have_link 'calendaradd'
    end
  end
end