class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.page(params[:page]).reverse_order
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end
end
