class PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

    # API呼び出し、緯度経度を代入
    require 'net/https'
    require 'json'
    require 'uri'

    address = URI.encode(@place.address)
    key = ENV['GMAP_API_KEY']
    uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{key}")
    http = Net::HTTP.new(uri.host, uri.port)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json, {:symbolize_names => true})
    @place.latitude = result[:results][0][:geometry][:location][:lat]
    @place.longitude = result[:results][0][:geometry][:location][:lng]

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'ライブ会場を登録しました' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @places = Place.page(params[:page]).reverse_order
    @search = Place.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end

  def show
    @key = ENV['GMAP_API_KEY']
    @place = Place.find(params[:id])
  end

  protected
    def place_params
      params.require(:place).permit(:address, :place_name, :latitude, :longitude)
    end
end
