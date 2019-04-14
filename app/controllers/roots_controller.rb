class RootsController < ApplicationController
  include Find_pop_events
  before_action :authenticate_admin, only: [:admin_top]

  def top
    #検索画面用
    @search = Event.from_now.ransack(params[:q])

    #人気ライブ表示用
    @pop_events = find_pop_events
  end

  def admin_top
  end
end
