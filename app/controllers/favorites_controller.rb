class FavoritesController < ApplicationController
  before_action :set_event

  def create
    if user_signed_in?
      favorite = current_user.favorites.new(event_id: @event.id)
      favorite.save
    else
      flash[:notice] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  def destroy
    if user_signed_in?
      favorite = current_user.favorites.find_by(event_id: @event.id)
      favorite.destroy
    else
      flash[:notice] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
