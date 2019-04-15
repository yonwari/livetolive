require "rails_helper"

RSpec.describe InquiryMailer, type: :mailer do
  describe "お問い合わせメール機能" do
    let(:inquiry) { FactoryBot.create(:inquiry) }
    let(:mail) { InquiryMailer.received_email(inquiry) }

    it "正しいメールアドレスから送信すること" do
      expect(mail.from).to eq ["noreply@livetolive.com"]
    end

    it "サポート用のメールアドレスへ送信すること" do
      expect(mail.to).to eq ["shaka_shaka_hoteken@yahoo.co.jp"]
    end

    it "正しい件名で送信すること" do
      expect(mail.subject).to eq "お問い合わせメールが届きました"
    end

    it "ユーザーのお問い合わせ内容が含まれていること" do
      expect(mail.body).to match inquiry.message
    end

    it "ユーザーのメールアドレスが含まれていること" do
      expect(mail.body).to match inquiry.email
    end
  end
end
