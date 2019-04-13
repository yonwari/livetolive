class FavoritesController < ApplicationController
  before_action :set_event
  
  def create
    favorite = current_user.favorites.new(event_id: @event.id)
    favorite.save
    flash[:notice] = "#{@event.event_title}をお気に入りに登録しました"
    redirect_to user_path(current_user)
  end

  def destroy
    favorite = current_user.favorites.find_by(event_id: @event.id)
    favorite.destroy
    flash[:notice] = "#{@event.event_title}をお気に入りから削除しました"
    redirect_to user_path(current_user)
  end
  
  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
