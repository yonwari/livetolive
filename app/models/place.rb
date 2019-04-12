class Place < ApplicationRecord
  has_many :events
  validates :place_name, presence: true, length: { maximum: 80 }, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  #geokit緯度経度検索用
  acts_as_mappable  :default_units => :kms,
                    :lat_column_name => :latitude,
                    :lng_column_name => :longitude

  #APIでの緯度経度取得処理
  def set_geocode_by_googleAPI
    begin
      api_address = URI.encode(self.address)
      key = Rails.application.credentials.api_key[:google]
      uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=#{api_address}&key=#{key}")
      json = Net::HTTP.get(uri)
      result = JSON.parse(json, {:symbolize_names => true})
      
      #結果を代入
      self.latitude = result[:results][0][:geometry][:location][:lat]
      self.longitude = result[:results][0][:geometry][:location][:lng]
    rescue => e
      logger.error e 
    end
  end
end
