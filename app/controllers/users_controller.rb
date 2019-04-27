class UsersController < ApplicationController
  before_action :authenticate_admin, only: [:index]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page]).per(10).reverse_order
  end

  def show
    @today_events = @user.events.today.recent
    #場所情報を配列にまとめてJSに渡す
    gon.places = @today_events.map(&:place)

    #カレンダー表示jbuilder用
    @my_events = @user.events
    gon.user_id = @user.id

    #お気に入りリスト表示用
    favorites = @user.favorites
    @my_favorites = favorites.map(&:event)
    @my_favorites = Kaminari.paginate_array(@my_favorites).page(params[:page]).per(5) #kaminari用

    #通知があった場合は既読として削除する
    if notifications = current_user.notifications
      #全件削除失敗時はロールバック
      notifications.transaction do
        records = notifications.destroy_all
        unless records.all?(&:destroyed?)
          raise ActiveRecord::Rollback
        end
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新に成功しました"
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

  protected
    def user_params
      params.require(:user).permit(:user_name, :email)
    end
end
