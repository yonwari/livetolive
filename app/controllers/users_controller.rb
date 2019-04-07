class UsersController < ApplicationController
  before_action :authenticate_admin, only: [:index]

  def index
    @users = User.page(params[:page]).reverse_order
    @search = User.ransack(params[:q])
    @result = @search.result.page(params[:page])
  end

  private
    def authenticate_admin
      unless current_user.admin?
        redirect_to events_path
      end
    end
end
