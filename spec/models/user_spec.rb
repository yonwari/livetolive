require 'rails_helper'

RSpec.describe User, type: :model do

  it "名前とメールアドレスとパスワードがあれば正常に登録できること" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  it "名前がなければ無効な状態であること" do
    user = FactoryBot.build(:user, user_name: nil)
    expect(user).not_to be_valid
  end
  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end
  it "重複したメールアドレスなら無効になること" do
    FactoryBot.create(:user, user_name:"taro")
    user = FactoryBot.build(:user, user_name:"hanako")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  it "形式の異なるメールアドレスなら無効になること" do
    user = FactoryBot.build(:user, email:"hanako")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end


end
