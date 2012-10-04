class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index

    @bnb = Bnb.find(params[:bnb_id])
    @bookings = Booking.active_bookings_by_bnb(@bnb)
    @events = Event.scoped.all(conditions: { booking_id: @bookings })

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events.as_json }
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    @event.start_at = Date.parse(params[:start_at]).strftime("%Y-%m-%d")
    @event.end_at = Date.parse(params[:end_at]).strftime("%Y-%m-%d")

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render json: @event.as_json }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def filter_by_status
    @events = Event.scoped.joins(:booking).where('bookings.status =?', params[:status])
    respond_to do |format|
      format.json {render json: @events.as_json}
    end
  end

end
