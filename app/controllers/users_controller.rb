class UsersController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).reverse_order
  end

  def show
    @key = Rails.application.credentials.api_key[:google] #map表示用
    @today_events = @user.events.today.recent

    #場所情報を配列にまとめる
    gon.places = []
    @today_events.each do |event|
      gon.places << event.place
    end

    #カレンダー表示jbuilder用
    @my_events = @user.events
    gon.user_id = current_user.id

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
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新に成功しました"
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

  protected
    def user_params
      params.require(:user).permit(:user_name, :email)
    end
end
