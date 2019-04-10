FactoryBot.define do
  factory :place do
    place_name { "テスト会場" }
    address { "東京都練馬区下石神井" }
    latitude { 35.7329 }
    longitude { 139.603 }
    trait :invalid do
      place_name nil
    end
  end
end