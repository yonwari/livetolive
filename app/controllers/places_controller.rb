class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

    # API呼び出し、緯度経度を代入
    if @place.address.present?
      @place.geocoding_set
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
      @place.geocoding_set
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

  def show
    @key = Rails.application.credentials.api_key[:google]
    @place = Place.find(params[:id])
  end

  protected
    def place_params
      params.require(:place).permit(:address, :place_name, :latitude, :longitude)
    end
end
