class EventsController < ApplicationController
  def index
    @search = Event.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).reverse_order
  end

  def show

  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "ライブ情報の登録に成功しました"
      redirect_to events_path
    else
      render :new
    end
  end

  def edit

  end
  def update

  end

  def event_params
    params.require(:event).permit(:event_title, :start_date, :end_date, :place_id, :explanation, :reserve_url, :open_date, :event_image)
  end
end
