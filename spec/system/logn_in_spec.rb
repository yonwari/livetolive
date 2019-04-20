require 'rails_helper'

RSpec.feature "Log in", :devise do
  describe 'ログイン機能', type: :system do
    before do
      @user = FactoryBot.create(:user)
    end
    it "メールアドレスとパスワードがあれば正常にログインできること" do
      sign_in("test1@example.com", "password")
      expect(page).to have_content("ログインしました")
    end

    it "パスワードなしではログインできないこと" do
      sign_in("test1@example.com", "")
      expect(current_path).to eq(new_user_session_path)
    end

    it "メールアドレスなしではログインできないこと" do
      sign_in("", "password")
      expect(current_path).to eq(new_user_session_path)
    end
  end
  describe 'ログアウト機能', type: :system do
    before do
      @user = FactoryBot.create(:user)
      sign_in("test1@example.com", "password")
      click_link 'LOG OUT'
    end
    it "正常にログインした後、ログアウトできること" do
      expect(page).to have_content("ログアウトしました")
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

def sign_in(email, password)
  visit new_user_session_path
  fill_in "メールアドレス", with: email
  fill_in "パスワード", with: password
  click_button "ログイン"
end