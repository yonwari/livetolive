class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]

  def index
    @search = Event.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).reverse_order
  end

  def show
    @key = ENV['GMAP_API_KEY'] #map表示用
    @place = @event.place
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
    if @event.update(event_params)
      flash[:notice] = "ライブ情報を更新しました"
      redirect_to @event
    else
      render :edit
    end

  end

  # 芸人タグページ表示用
  def Comediantag
    @user = current_user
    @comedian = Comedian.find_by(comedian_name: params[:name])
    @events = @comedian.events.build
    @event  = @comedian.events.page(params[:page])
  end

  # 共通のセット処理
  private
    def set_event
      @event = Event.find_by(id: params[:id])
    end

  # ストロングパラメータ
  protected
    def event_params
      params.require(:event).permit(:event_title, :start_date, :end_date, :place_id, :explanation, :reserve_url, :open_date, :event_image, :comedianlist)
    end
end
