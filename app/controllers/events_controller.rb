class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index

    @bnb = Bnb.find(params[:bnb_id])
    @bookings = Booking.active_bookings_by_bnb(@bnb)
    @events = Event.scoped.all(:include => [:booking => :bnb], conditions: { booking_id: @bookings })

    respond_to do |format|
      format.json { render json: @events.as_json, layout: false }
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    @event.start_at = Date.parse(params[:start_at]).strftime("%Y-%m-%d")
    @event.end_at = Date.parse(params[:end_at]).strftime("%Y-%m-%d")

    respond_to do |format|
      @event.save ?
          format.js { render json: @event.as_json, layout: false } :
          format.js {  render json: @event.errors, layout: false, status: :unprocessable_entity }


    end
  end
end
