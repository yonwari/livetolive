require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  it "名前とメールアドレスとメッセージがあれば有効な状態であること" do
    inquiry = FactoryBot.build(:inquiry)
    expect(inquiry).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    inquiry = FactoryBot.build(:inquiry, name: nil)
    expect(inquiry).not_to be_valid
  end
  it "メールアドレスがなければ無効な状態であること" do
    inquiry = FactoryBot.build(:inquiry, email: nil)
    expect(inquiry).not_to be_valid
  end
  it "メッセージがなければ無効な状態であること" do
    inquiry = FactoryBot.build(:inquiry, message: nil)
    expect(inquiry).not_to be_valid
  end
end
