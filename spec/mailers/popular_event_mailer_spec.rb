require "rails_helper"

RSpec.describe PopularEventMailer, type: :mailer do
  describe "人気ライブ送信機能" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { PopularEventMailer.send_message_to_user(user) }

    it "正しいメールアドレスから送信すること" do
      expect(mail.from).to eq ["noreply@livetolive.com"]
    end
    it "ユーザーのメールアドレスへ送信すること" do
      expect(mail.to).to eq [user.email]
    end
    it "正しい件名で送信すること" do
      expect(mail.subject).to eq "【livetolive】今週の人気イベントトップ10！"
    end
  end
end
