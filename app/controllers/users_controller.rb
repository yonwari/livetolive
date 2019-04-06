class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).reverse_order
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end
end
