FactoryBot.define do
  factory :notification do
    user_id { 1 }
    event_id { 1 }
    read_flg { false }
  end
end
