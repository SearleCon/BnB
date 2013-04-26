class EventsController < ApplicationController
  respond_to :json
  before_filter :get_events

  caches_action :index, cache_path: proc { |c|  {tag: current_user.bnb} }

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
