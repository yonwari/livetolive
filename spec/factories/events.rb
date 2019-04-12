FactoryBot.define do
  factory :event do
    event_title { "テストライブ" }
    start_date { DateTime.now.since(9999999) }
    open_date { DateTime.now.since(999999) }
    end_date { DateTime.now.since(99999999) }
    explanation { "test" }
    reserve_url { "https://www.yahoo.co.jp/" }
    comedianlist { "#test #test2" }
    place
  end
end