class PopularEventMailer < ApplicationMailer
  add_template_helper(ActionView::Helpers::UrlHelper)
  default from: 'noreply@livetolive.com'

  # ユーザーへの自動返信メール
  def send_message_to_user(user)
    @pop_events = Event.from_now.select('events.*', 'count(calendar_events.id) AS calendars').left_joins(:calendar_events).group('events.id').limit(10).order('calendars desc')
    mail to: user.email,
        subject: "【livetolive】今週の人気イベントトップ10！"
  end
end
