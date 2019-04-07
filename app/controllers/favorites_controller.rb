class FavoritesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    favorite = current_user.favorites.new(event_id: event.id)
    favorite.save
  end

  def destroy
    event = Event.find(params[:event_id])
    favorite = current_user.favorites.find_by(event_id: event.id)
    favorite.destroy
  end
  
end
