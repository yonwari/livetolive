module Find_pop_events
  extend ActiveSupport::Concern

  included do
    helper_method :find_pop_events
  end

  #人気ライブ取得
  def find_pop_events
    Event.from_now.select('events.*', 'count(calendar_events.id) AS calendars').left_joins(:calendar_events).group('events.id').limit(10).order('calendars desc')
  end
end