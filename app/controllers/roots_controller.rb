class RootsController < ApplicationController
  def top
    #検索画面用
    @search = Event.from_now.ransack(params[:q])

    #人気ライブ表示用
    @pop_events = Event.select('events.*', 'count(calendar_events.id) AS calendars')
    .left_joins(:calendar_events)
    .group('events.id')
    .limit(10)
    .order('calendars desc')
  end

  def admin_top
  end
end
