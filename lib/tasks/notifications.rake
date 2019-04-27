namespace :notifications do
  desc "本日開催のライブがあれば通知を作成する"
  task notifications: :environment do
    users = User.all
    users.each do |user|
      user.make_notification
    end
  end
end
