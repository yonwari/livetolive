require 'rails_helper'

describe 'お問い合わせ機能', type: :system do
  let(:user) { FactoryBot.create(:user) }

  context '未ログインの時' do
    context '名前が未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: "testuser"
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'お問い合わせ内容', with: "テスト用のお問い合わせです。"
        click_button '確認'
        click_button '送信する'
      end
      it "送信完了画面に遷移する" do
        expect(current_path).to eq(thanks_path)
        expect(page).to have_content 'お問い合わせを送信しました'
      end
    end
    context 'メールアドレスが未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: "testuser"
        fill_in 'メールアドレス', with: ""
        fill_in 'お問い合わせ内容', with: "テスト用のお問い合わせです。"
        click_button '確認'
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content '入力内容に誤りがあります'
      end
    end
    context 'メッセージが未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: "testuser"
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'お問い合わせ内容', with: ""
        click_button '確認'
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content '入力内容に誤りがあります'
      end
    end
    context '名前が未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: ""
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'お問い合わせ内容', with: "テスト用のお問い合わせです。"
        click_button '確認'
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content '入力内容に誤りがあります'
      end
    end
  end


  context 'ログイン済みの時' do
    before do
      # ログイン
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end
    let(:login_user) { user }
    context '名前が未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: "testuser"
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'お問い合わせ内容', with: "テスト用のお問い合わせです。"
        click_button '確認'
        click_button '送信する'
      end
      it "送信完了画面に遷移する" do
        expect(current_path).to eq(thanks_path)
        expect(page).to have_content 'お問い合わせを送信しました'
      end
    end
    context 'メールアドレスが未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: "testuser"
        fill_in 'メールアドレス', with: ""
        fill_in 'お問い合わせ内容', with: "テスト用のお問い合わせです。"
        click_button '確認'
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content '入力内容に誤りがあります'
      end
    end
    context 'メッセージが未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: "testuser"
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'お問い合わせ内容', with: ""
        click_button '確認'
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content '入力内容に誤りがあります'
      end
    end
    context '名前が未入力だった時' do
      before do
        visit inquiries_new_path
        fill_in 'お名前', with: ""
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'お問い合わせ内容', with: "テスト用のお問い合わせです。"
        click_button '確認'
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content '入力内容に誤りがあります'
      end
    end
  end
  # context 'ログイン済みの時' do
  #   before do
  #     # ログイン
  #     visit new_user_session_path
  #     fill_in 'メールアドレス', with: login_user.email
  #     fill_in 'パスワード', with: login_user.password
  #     click_button 'ログイン'
  #   end
  #   let(:login_user) { user }
  #   context '名前とメールアドレスとメッセージを入力した時' do

  #   end
  #   context '名前が未入力だった時' do
  #   end
  #   context 'メールアドレスが未入力だった時' do

  #   end
  #   context 'メッセージが未入力だった時' do

  #   end
  # end
end