class CalendarEventsController < ApplicationController
  before_action :set_event

  def create
    calendar_event = current_user.calendar_events.new(event_id: @event.id)
    calendar_event.save
    flash[:notice] = "カレンダーに登録しました"
    redirect_to event_path(@event)
  end

  def destroy
    calendar_event = current_user.calendar_events.find_by(event_id: @event.id)
    calendar_event.destroy
    flash[:notice] = "カレンダーから削除しました"
    redirect_to event_path(@event)
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
