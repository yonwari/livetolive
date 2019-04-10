require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe "#index" do
    context "管理者ユーザーの時" do
      before do
        @admin_user = FactoryBot.create(:admin_user)
      end
      it "正常にレスポンスを返すこと" do
        sign_in @admin_user
        get :index
        expect(response).to be_success
      end
      it "200レスポンスを返すこと" do
        sign_in @admin_user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "一般ユーザーの時" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "イベント一覧にリダイレクトされること" do
        sign_in @user
        get :index
        expect(response).to redirect_to "/events"
      end
      it "302レスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status "302"
      end
    end
  end

  describe "#show" do
    context "管理者ユーザーの時" do
      before do
        @admin_user = FactoryBot.create(:admin_user)
        @place = FactoryBot.create(:place)
      end
      it "正常にレスポンスを返すこと" do
        sign_in @admin_user
        get :show, params: { id: @place.id }
        expect(response).to be_success
      end
      it "200レスポンスを返すこと" do
        sign_in @admin_user
        get :show, params: { id: @place.id }
        expect(response).to have_http_status "200"
      end
    end

    context "一般ユーザーの時" do
      before do
        @user = FactoryBot.create(:user)
        @place = FactoryBot.create(:place)
      end
      it "イベント一覧にリダイレクトされること" do
        sign_in @user
        get :show, params: { id: @place.id }
        expect(response).to redirect_to "/events"
      end
      it "302レスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status "302"
      end
    end
  end


  describe "#create" do
    context "管理者の時" do
      before do
        @admin_user = FactoryBot.create(:admin_user)
      end
      context "有効な値の時" do
        it "会場を追加できること" do
          place_params = FactoryBot.attributes_for(:place)
          sign_in @admin_user
          expect {
            post :create, params: { place: place_params }
          }.to change(Place.all, :count).by(1)
        end
      end
      context "無効な値の時" do
        it "会場を追加できないこと" do
          place_params = FactoryBot.attributes_for(:place, :invalid)
          sign_in @admin_user
          expect {
            post :create, params: { place: place_params }
          }.to_not change(Place.all, :count)
        end
      end
    end

    context "一般ユーザーの時" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "302レスポンスを返すこと" do
        place_params = FactoryBot.attributes_for(:place)
        sign_in @user
        post :create, params: { place: place_params }
        expect(response).to have_http_status "302"
      end
      it "イベント一覧にリダイレクトすること" do
        place_params = FactoryBot.attributes_for(:place)
        sign_in @user
        post :create, params: { place: place_params }
        expect(response).to redirect_to "/events"
      end
    end
  end

  describe "#update" do
    context "管理者として" do
      before do
        @admin_user = FactoryBot.create(:admin_user)
        @place = FactoryBot.create(:place)
      end
      it "会場を更新できること" do
        place_params = FactoryBot.attributes_for(:place,
          place_name: "New Name")
        sign_in @admin_user
        patch :update, params: { id: @place.id, place: place_params }
        expect(@place.reload.place_name).to eq "New Name"
      end
    end

    context "一般ユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @place = FactoryBot.create(:place)
      end
      it "会場を更新できないこと" do
        place_params = FactoryBot.attributes_for(:place,
          place_name: "New Name")
        sign_in @user
        patch :update, params: { id: @place.id, place: place_params }
        expect(@place.reload.place_name).to eq "テスト会場"
      end
      it "イベント一覧へリダイレクトすること" do
        place_params = FactoryBot.attributes_for(:place,
          place_name: "New Name")
        sign_in @user
        patch :update, params: { id: @place.id, place: place_params }
        expect(response).to redirect_to "/events"
      end
    end


    context "ゲストとして" do
      before do
        @place = FactoryBot.create(:place)
      end
      it "302レスポンスを返すこと" do
        place_params = FactoryBot.attributes_for(:place)
        patch :update, params: { id: @place.id, place: place_params }
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトすること" do
        place_params = FactoryBot.attributes_for(:place)
        patch :update, params: { id: @place.id, place: place_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end

  end
end
