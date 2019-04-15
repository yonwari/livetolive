FactoryBot.define do
  factory :inquiry do
    name { "testuser" }
    email { "test@test.com" }
    message { "nice to meet you." }
  end
end
