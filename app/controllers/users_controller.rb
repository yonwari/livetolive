class UsersController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page]).reverse_order
  end

  def show
    @key = ENV['GMAP_API_KEY'] #map表示用
    # ここで本日分のみに絞り込み！
    calendar_events = @user.calendar_events
    
    @my_events = [] #イベント用配列
    @my_places = [] #JS引き渡し用の配列

    #カレンダー登録したイベントと場所情報を配列にまとめる
    calendar_events.each do |calendar_event|
      @my_events << calendar_event.event
      @my_places << [calendar_event.event.place.place_name,
                      calendar_event.event.place.address,
                      calendar_event.event.place.latitude, 
                      calendar_event.event.place.longitude]
    end
    @my_places_j = @my_places.to_json.html_safe

    # カレンダーjbuilder用
    gon.user_id = current_user.id

  end

  def edit
  end

  def update
  end

  private
    def authenticate_admin
      unless current_user.admin?
        redirect_to events_path
      end
    end

    def correct_user
      user = User.find_by(id: params[:id])
      unless current_user.id == user.id || current_user.admin?
        redirect_to events_path
      end
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
end
