require 'rails_helper'

RSpec.describe Place, type: :model do
  it "住所と会場名と緯度経度があれば有効な状態であること" do
      place = FactoryBot.build(:place)
      expect(place).to be_valid
  end
  # 名がなければ無効な状態であること 
  it "会場名がなければ無効な状態であること" do
    place = FactoryBot.build(:place, place_name: nil)
    expect(place).not_to be_valid
  end
  
  it "住所がなければ無効な状態であること" do
    place = FactoryBot.build(:place, address: nil)
    expect(place).not_to be_valid
  end
  
  it "APIでの緯度経度取得が成功すること" do
    place = Place.new(
      address: "東京都新宿区歌舞伎町２丁目４５−４",
      place_name: "新宿バティオス",
    )
    place.geocoding_set
    expect(place).to be_valid
  end
end