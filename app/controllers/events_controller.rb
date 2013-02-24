class EventsController < ApplicationController
  respond_to :json

  caches_action :index, :cache_path => proc {|c|
    key = current_user.bnb.bookings.active_bookings.maximum(:updated_at)
    {:tag => key.to_i} if key
  }

  # GET /events
  # GET /events.json
  def index
    @events = Event.scoped.includes(:booking => :bnb).where(:booking_id => current_user.bnb.bookings.active_bookings)
    respond_with(@events)
  end
end
