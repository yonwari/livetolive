FactoryBot.define do
  factory :event do
    event_title { "テストライブ" }
    start_date { "Thu, 18 Apr 2019 19:11:00 JST +09:00" }
    end_date { "Fri, 19 Apr 2019 21:11:00 JST +09:00" }
    place_id { 1 }
    explanation { "test" }
    reserve_url { "https://www.yahoo.co.jp/" }
    open_date { "Thu, 18 Apr 2019 18:11:00 JST +09:00" }
    comedianlist { "#test #test2" }
  end
end