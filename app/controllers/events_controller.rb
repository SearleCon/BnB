class EventsController < ApplicationController
  respond_to :json
  before_filter :get_events

  caches_action :index, cache_path: proc { |c|
    key = current_user.bnb.bookings.unscoped.maximum(:updated_at)
    {tag: key.to_i} if key
  }

  # GET /events
  # GET /events.json
  def index
    respond_with(@events)
  end

  private
  def get_events
   @events = Event.by_bookings(current_user.bnb.bookings.scoped)
  end

end
