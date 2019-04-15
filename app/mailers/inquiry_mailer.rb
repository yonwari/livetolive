class InquiryMailer < ApplicationMailer
  # 管理者への送信メール
  default from: 'noreply@livetolive.com'
  def received_email(inquiry)
    @inquiry = inquiry
    mail to: "shaka_shaka_hoteken@yahoo.co.jp",
          subject: "お問い合わせメールが届きました"
  end
end
