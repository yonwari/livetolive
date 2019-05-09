FactoryBot.define do
  factory :event do
    event_title { "テストライブ" }
    start_date { DateTime.now.since(660) }
    open_date { DateTime.now.since(600) }
    end_date { DateTime.now.since(720) }
    explanation { "test" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #today" }
    place
  end

  factory :tomorrow_event, class:Event do
    event_title { "明日用ライブ" }
    start_date { DateTime.now.tomorrow.since(660) }
    open_date { DateTime.now.tomorrow.since(600) }
    end_date { DateTime.now.tomorrow.since(720) }
    explanation { "test tomorrow" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #tomorrow" }
    association :place, factory: :shibuya, strategy: :create
  end

  factory :dat_event, class:Event do
    event_title { "明後日用ライブ" }
    start_date { DateTime.now.tomorrow.tomorrow.since(660) }
    open_date { DateTime.now.tomorrow.tomorrow.since(600) }
    end_date { DateTime.now.tomorrow.tomorrow.since(720) }
    explanation { "test dat" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #dat" }
    place
  end

  factory :nm_event, class:Event do
    event_title { "来月用ライブ" }
    start_date { DateTime.now.next_month.since(660) }
    open_date { DateTime.now.next_month.since(600) }
    end_date { DateTime.now.next_month.since(720) }
    explanation { "test nm" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2 #nm" }
    place
  end
end
