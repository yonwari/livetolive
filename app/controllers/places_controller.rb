class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:search]

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

    # API呼び出し、緯度経度を代入
    if @place.address.present?
      @place.set_geocode_by_googleAPI
    end

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'ライブ会場を登録しました' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @place = Place.find_by(id:params[:id])
  end

  def update
    @place = Place.find_by(id:params[:id])
    @place.address = params[:place][:address]
    @place.place_name = params[:place][:place_name]

    # API呼び出し、緯度経度を代入
    if @place.address.present?
      @place.set_geocode_by_googleAPI
    end

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'ライブ会場情報を更新しました' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :edit }
      end
    end
  end

  def index
    @search = Place.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).reverse_order
  end

  def search
    # 現在地取得
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @places = Place.all.within(3, origin: [@latitude, @longitude])

    @key = Rails.application.credentials.api_key[:google]
    #MAP整形用
    #場所情報を配列にまとめる
    @near_places = [] #MAPでJS引き渡し用の配列
    @places.each do |place|
      @near_places << [place.place_name,
                      place.address,
                      place.latitude,
                      place.longitude]
    end
    @near_places_j = @near_places.to_json.html_safe #JS引き渡しのため整形
  end

  def show
    @key = Rails.application.credentials.api_key[:google]
    @place = Place.find(params[:id])
  end

  protected
    def place_params
      params.require(:place).permit(:address, :place_name, :latitude, :longitude)
    end
end
