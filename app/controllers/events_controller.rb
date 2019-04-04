class EventsController < ApplicationController
  def index

  end
  def show

  end
  def new

  end
  def create

  end
  def edit

  end
  def update

  end

  def event_params
    params.require(:event).permit(:event_title, :start_date, :end_date, :place_id, :explanation, :reserve_url, :open_date, :deleted_at)
  end
end
