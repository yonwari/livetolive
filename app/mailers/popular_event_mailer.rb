class PopularEventMailer < ApplicationMailer
  add_template_helper(ActionView::Helpers::UrlHelper)
  include Find_pop_events
  default from: 'noreply@livetolive.com'

  # ユーザーへの自動返信メール
  def send_message_to_user(user)
    @pop_events = find_pop_events
    mail to: user.email,
        subject: "【livetolive】今週の人気イベントトップ10！"
  end
end
