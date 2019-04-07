class FavoritesController < ApplicationController
  before_action :set_event
  
  def create
    favorite = current_user.favorites.new(event_id: @event.id)
    favorite.save
  end

  def destroy
    favorite = current_user.favorites.find_by(event_id: @event.id)
    favorite.destroy
  end
  
  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
