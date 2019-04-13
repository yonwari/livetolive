class RootsController < ApplicationController
  before_action :authenticate_admin, only: [:admin_top]

  def top
    #検索画面用
    @search = Event.from_now.ransack(params[:q])

    #人気ライブ表示用
    @pop_events = Event.from_now.select('events.*', 'count(calendar_events.id) AS calendars').left_joins(:calendar_events).group('events.id').limit(10).order('calendars desc')
  end

  def admin_top
  end
end
