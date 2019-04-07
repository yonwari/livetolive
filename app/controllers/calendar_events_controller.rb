class CalendarEventsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    calendar_event = current_user.calendar_events.new(event_id: event.id)
    calendar_event.save
    flash[:notice] = "カレンダーに登録しました"
    redirect_to user_path(current_user)
  end

  def destroy
    event = Event.find(params[:event_id])
    calendar_event = current_user.calendar_events.find_by(event_id: event.id)
    calendar_event.destroy
    flash[:notice] = "カレンダーから削除しました"
    redirect_to user_path(current_user)
  end
end
