class CalendarEventsController < ApplicationController
  before_action :set_event

  def create
    if user_signed_in?
      calendar_event = current_user.calendar_events.new(event_id: @event.id)
      calendar_event.save
    else
      flash[:notice] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  def destroy
    if user_signed_in?
      calendar_event = current_user.calendar_events.find_by(event_id: @event.id)
      calendar_event.destroy
    else
      flash[:notice] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
