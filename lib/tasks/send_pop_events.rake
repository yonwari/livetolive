namespace :send_pop_events do
  desc "人気のライブをメール送信する"
  task send_pop_events: :environment do
    users = User.all
    users.each do |user|
      PopularEventMailer.send_message_to_user(user).deliver
    end
  end
end