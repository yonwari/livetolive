class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]

  def index
    #複数条件検索用にパラメータ分割
    search_words = params[:q].delete(:event_title_or_comedianlist_or_place_place_name_or_place_address_cont) if params[:q].present?
    if search_words.present?
      params[:q][:groupings] = []
      search_words.split(/[ 　]/).each_with_index do |word, i| #空白で切って、単語ごとに処理
        params[:q][:groupings][i] = { event_title_or_comedianlist_or_place_place_name_or_place_address_cont: word }
      end
    end

    @search = Event.from_now.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).recent
  end

  def show
    @place = @event.place
    # 近くのカフェ表示用
    gon.place = @place
    # 会場MAP形成JS引き渡し用
    gon.places = [@place]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "ライブ情報の登録に成功しました"
      redirect_to @event
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
