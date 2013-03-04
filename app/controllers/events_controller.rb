class EventsController < ApplicationController
  respond_to :json
  before_filter :get_events

  caches_action :index, :cache_path => proc {|c|
    key = current_user.bnb.bookings.maximum(:updated_at)
    {:tag => key.to_i} if key
  }

  # GET /events
  # GET /events.json
  def index
    respond_with(@events.by_bnb(current_user.bnb))
  end

  private
  def get_events
    @events = Event.scoped.includes(:booking => :bnb)
  end
end
