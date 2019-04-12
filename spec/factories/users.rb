FactoryBot.define do
  factory :user do
    user_name { "テストユーザー" }
    email { "test1@example.com" }
    password { "password" }
  end

  factory :user_2, class:User do
    user_name { "テストユーザー2" }
    email { "test2@example.com" }
    password { "password" }
  end

  factory :admin_user, class:User do
    user_name { '管理者' }
    email { "admin@admin.com" }
    password { "password" }
    admin { true }
  end
end