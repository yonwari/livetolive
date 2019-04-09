class UsersController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).reverse_order
  end

  def show
    @key = ENV['GMAP_API_KEY'] #map表示用
    @my_events = @user.events
    @today_events = @user.events.today

    #場所情報を配列にまとめる
    @my_places = [] #MAPでJS引き渡し用の配列
    @today_events.each do |event|
      @my_places << [event.place.place_name,
                      event.place.address,
                      event.place.latitude, 
                      event.place.longitude]
    end
    @my_places_j = @my_places.to_json.html_safe #JS引き渡しのため整形
    gon.user_id = current_user.id # カレンダー表示jbuilder用

    #お気に入りリスト表示用
    favorites = @user.favorites
    @my_favorites = []
    favorites.each do |fav|
      @my_favorites << fav.event
    end
    @my_favorites = Kaminari.paginate_array(@my_favorites).page(params[:page]).per(5) #kaminari用

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
