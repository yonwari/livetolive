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
  factory :shibuya, class:Place do
    place_name { "渋谷会場" }
    address { "東京都渋谷区円山町" }
    latitude { 35.6566	 }
    longitude { 139.694 }
    trait :invalid do
      place_name nil
    end
  end
end