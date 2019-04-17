require 'rails_helper'

RSpec.feature "Sign Up", :devise do
  describe '会員登録機能', type: :system do
    it "メールアドレスとパスワードとユーザーネームがあれば正常に登録できること" do
      sign_up_with("test@example.com", "hanako", "password", "password")

      txts = [I18n.t("devise.registrations.signed_up"),
              I18n.t("devise.registrations.signed_up_but_unconfirmed")]
      expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
    end

    it "パスワードなしでは登録できないこと" do
      sign_up_with("test@example.com", "hanako", "", "")
      expect(page).to have_content("パスワードを入力してください")
    end

    it "パスワードが６文字以内だと登録できないこと" do
      sign_up_with("test@example.com", "hanako", "1234", "1234")
      expect(page).to have_content("パスワードは6文字以上で入力してください")
    end

    it "確認用パスワードなしでは登録できないこと" do
      sign_up_with("test@example.com", "hanako", "password", "")
      expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
    end

    it "確認用パスワードが異なると登録できないこと" do
      sign_up_with("test@example.com", "hanako", "password", "mismatch")
      expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
    end
  end
end

def sign_up_with(email, user_name, password, confirmation)
  visit new_user_registration_path
  fill_in "メールアドレス", with: email
  fill_in "ユーザー名", with: user_name
  fill_in "パスワード", with: password
  fill_in "確認用パスワード", with: confirmation
  click_button "登録する"
end