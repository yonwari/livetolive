require 'rails_helper'

RSpec.describe Place, type: :model do
  it "住所と会場名と緯度経度があれば有効な状態であること" do
    place = FactoryBot.build(:place)
    expect(place).to be_valid
  end

  it "会場名がなければ無効な状態であること" do
    place = FactoryBot.build(:place, place_name: nil)
    expect(place).not_to be_valid
  end
  it "重複する会場名では無効な状態であること" do
    FactoryBot.create(:place, place_name: "testplace", address: "東京都新宿区歌舞伎町１−１")
    place = FactoryBot.build(:place, place_name: "testplace", address: "東京都新宿区歌舞伎町１−２")
    place.valid?
    expect(place.errors[:place_name]).to include("はすでに存在します")
  end

  it "住所がなければ無効な状態であること" do
    place = FactoryBot.build(:place, address: nil)
    expect(place).not_to be_valid
  end
  it "重複する住所では無効な状態であること" do
    FactoryBot.create(:place, place_name: "testplace3", place_name: "東京都渋谷区円山町")
    place = FactoryBot.build(:place, place_name: "testplace4", place_name: "東京都渋谷区円山町")
    place.valid?
    expect(place.errors[:place_name]).to include("はすでに存在します")
  end

  context "住所を正しく受け取った時" do
    it "APIでの緯度経度取得が成功すること" do
      place = Place.new(
        address: "東京都新宿区歌舞伎町２丁目４５−４",
        place_name: "新宿バティオス",
      )
      place.set_geocode_by_googleAPI
      expect(place.latitude).to be_within(1.0).of(35)
      expect(place.longitude).to be_within(1.0).of(139)
      expect(place).to be_valid
    end
  end

  context "住所を受け取らなかった時" do
    it "APIでの緯度経度取得が失敗すること" do
      place = Place.new(
        address: "",
        place_name: "新宿バティオス",
      )
      place.set_geocode_by_googleAPI
      expect(place.latitude).not_to be_within(1.0).of(35)
      expect(place.longitude).not_to be_within(1.0).of(139)
      expect(place).not_to  be_valid
    end
  end
end