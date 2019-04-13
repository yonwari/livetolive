require 'rails_helper'

describe 'イベント検索機能' do
  place = FactoryBot.create(:place)
  shibuya = FactoryBot.create(:shibuya)
  today_event = FactoryBot.create(:event)
  tomorrow_event = FactoryBot.create(:tomorrow_event)
  dat_event = FactoryBot.create(:dat_event)

  before do
    visit root_path
  end

  context '今日のライブボタンを押した時' do
    before do
      click_button "今日のライブ"
    end
    it "本日開催のイベントが表示される" do
      expect(page).to have_content "ライブ情報一覧"
      expect(page).to have_content "テストライブ"
    end
  end

  context '明日のライブボタンを押した時' do
    before do
      click_button "明日のライブ"
    end
    it "明日開催のイベントが表示される" do
      expect(page).to have_content "ライブ情報一覧"
      expect(page).to have_content "明日用ライブ"
    end
  end

  context '検索バーに入力した時' do
    context '全て空で検索ボタンを押した時' do
      before do
        click_button "search"
      end
      it "全てのライブが表示される" do
        expect(page).to have_content "ライブ情報一覧"
        expect(page).to have_content "テストライブ"
        expect(page).to have_content "明日用ライブ"
      end

    end
    context '会場名を指定した時' do
      before do
        fill_in "q[event_title_or_comedianlist_or_place_place_name_or_place_address_cont]",
          with: "渋谷会場"
        click_button "search"
      end

      it "渋谷会場のライブのみが表示される" do
        expect(page).to have_content "渋谷会場"
        expect(page).not_to have_content "テスト会場"
      end
    end

    context '芸人名を指定した時' do
      before do
        fill_in "q[event_title_or_comedianlist_or_place_place_name_or_place_address_cont]",
          with: "dat"
        click_button "search"
      end

      it "datが出演するライブのみが表示される" do
        expect(page).to have_content "#dat"
        expect(page).not_to have_content "#today"
        expect(page).not_to have_content "#tomorrow"
      end
    end
    context 'ライブ名を指定した時' do
      before do
        fill_in "q[event_title_or_comedianlist_or_place_place_name_or_place_address_cont]",
          with: "明日用ライブ"
        click_button "search"
      end

      it "「明日用ライブ」のみが表示される" do
        expect(page).to have_content "明日用ライブ"
        expect(page).not_to have_content "テストライブ"
        expect(page).not_to have_content "明後日用ライブ"
      end
    end
    context '地域名で検索した時' do
      before do
        fill_in "q[event_title_or_comedianlist_or_place_place_name_or_place_address_cont]",
          with: "練馬区"
        click_button "search"
      end

      it "練馬区開催のライブのみが表示される" do
        expect(page).to have_content "テストライブ"
        expect(page).not_to have_content "明日用ライブ"
        expect(page).to have_content "明後日用ライブ"
      end
    end
    context '該当するライブ情報が登録されていない時' do
      before do
        fill_in "q[event_title_or_comedianlist_or_place_place_name_or_place_address_cont]",
          with: "台東区"
        click_button "search"
      end
      it "検索結果がありませんと表示される" do
        expect(page).to have_content "検索結果はありません"
      end
    end
  end
end