class PlacesController < ApplicationController
  before_action :authenticate_user!, except: [:search]
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
    # 現在地から3km以内の会場を取得
    gon.latitude = params[:latitude]
    gon.longitude = params[:longitude]
    @places = Place.all.within(3, origin: [gon.latitude, gon.longitude])
    gon.places = @places  #JS引き渡し用
  end

  def show
    @place = Place.find(params[:id])
    # MAP形成JS引き渡し用
    gon.places = [@place]
  end

  protected
    def place_params
      params.require(:place).permit(:address, :place_name, :latitude, :longitude)
    end
end
