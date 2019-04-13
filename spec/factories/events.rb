FactoryBot.define do
  factory :event do
    event_title { "テストライブ" }
    start_date { DateTime.now.since(600) }
    open_date { DateTime.now.since(660) }
    end_date { DateTime.now.since(720) }
    explanation { "test" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #today" }
    place
  end

  factory :tomorrow_event, class:Event do
    event_title { "明日用ライブ" }
    start_date { DateTime.now.tomorrow }
    open_date { DateTime.now.tomorrow }
    end_date { DateTime.now.tomorrow }
    explanation { "test tomorrow" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #tomorrow" }
    association :place, factory: :shibuya, strategy: :create
  end

  factory :dat_event, class:Event do
    event_title { "明後日用ライブ" }
    start_date { DateTime.now.tomorrow.tomorrow }
    open_date { DateTime.now.tomorrow.tomorrow }
    end_date { DateTime.now.tomorrow.tomorrow }
    explanation { "test dat" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #dat" }
    place
  end
end