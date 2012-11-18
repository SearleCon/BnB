class EventsController < ApplicationController
  respond_to :json

  caches_action :index, :cache_path => proc {|c|
    event = Event.order('updated_at DESC').limit(1).first
    unless event.nil?
     {:tag => event.updated_at.to_i}
    end
  }

  # GET /events
  # GET /events.json
  def index

    @bnb = current_user.bnb
    @bookings = Booking.active_bookings_by_bnb(@bnb)
    @events = Event.scoped.all(:include => [:booking => :bnb], conditions: { booking_id: @bookings })

    respond_with(@events)
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    @event.start_at = Date.parse(params[:start_at]).strftime("%Y-%m-%d")
    @event.end_at = Date.parse(params[:end_at]).strftime("%Y-%m-%d")
    @event.save

    respond_with(@event)
  end
end
