require 'rails_helper'

RSpec.describe Event, type: :model do
  it "必要条件があれば有効な状態であること" do
    event = FactoryBot.build(:event)
    expect(event).to be_valid
  end
  it "イベント名がなければ無効な状態であること" do
    event = FactoryBot.build(:event, event_title: nil)
    expect(event).not_to be_valid
  end
  it "イベント名が100文字以上ならば無効な状態であること" do
    event = FactoryBot.build(:event, event_title: "aa"*100)
    expect(event).not_to be_valid
  end
  it "開演時間がなければ無効な状態であること" do
    event = FactoryBot.build(:event, start_date: nil)
    expect(event).not_to be_valid
  end
  it "終演時間がなければ無効な状態であること" do
    event = FactoryBot.build(:event, end_date: nil)
    expect(event).not_to be_valid
  end
  it "説明文がなければ無効な状態であること" do
    event = FactoryBot.build(:event, explanation: nil)
    expect(event).not_to be_valid
  end
  it "説明文が200文字以上ならば無効な状態であること" do
    event = FactoryBot.build(:event, explanation: "qqq"*100)
    expect(event).not_to be_valid
  end
  it "予約urlがなければ無効な状態であること" do
    event = FactoryBot.build(:event, reserve_url: nil)
    expect(event).not_to be_valid
  end
  it "開場時間がなければ無効な状態であること" do
    event = FactoryBot.build(:event, open_date: nil)
    expect(event).not_to be_valid
  end

  # scopeテスト
  describe "scope" do
    describe "from_now" do
      let!(:new_event) { FactoryBot.create(:event, start_date: DateTime.now.tomorrow) }
      let!(:old_event) { FactoryBot.create(:event, start_date: DateTime.now.yesterday) }
      subject { Event.from_now }
      it { is_expected.to include new_event }
      it { is_expected.not_to include old_event }
    end
    describe "today" do
      let!(:first_event) { FactoryBot.create(:event, start_date: DateTime.now.beginning_of_day) }
      let!(:last_event) { FactoryBot.create(:event, start_date: DateTime.now.end_of_day) }
      let!(:tomorrow_event) { FactoryBot.create(:event, start_date: DateTime.now.tomorrow) }
      let!(:yesterday_event) { FactoryBot.create(:event, start_date: DateTime.now.yesterday) }
      subject { Event.today }
      it { is_expected.to include first_event }
      it { is_expected.to include last_event }
      it { is_expected.not_to include tomorrow_event }
      it { is_expected.not_to include yesterday_event }
    end
  end
end