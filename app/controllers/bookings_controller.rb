class BookingsController < ApplicationController


  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    @booking = Booking.find(params[:id])
    if request.xhr?
      booking = render_to_string :partial => 'bookings/show', :locals => {:booking => @booking}
      booking = booking.html_safe.gsub(/[\n\t\r]/, '')
      render :json => {:html => booking, :error => '' }
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @booking }
      end
    end
  end

  # GET /bookings/new
  # GET /bookings/new.json
  def new


    @booking = Booking.new
    @booking.build_event

    params[:date] ? selected_day = Date.parse(params[:date]) : selected_day = Date.today
    @booking.event.start_at = selected_day.strftime('%A, %d %B %Y')
    @booking.event.end_at = (selected_day + 1.days).strftime('%A, %d %B %Y')

    if request.xhr?
      event_details = render_to_string :partial => 'bookings/form'
      event_details = event_details.html_safe.gsub(/[\n\t\r]/, '')
      render :json => {:html => event_details, :error => '' }
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @booking }
      end
    end
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(params[:booking])
    @booking.event.name = @booking.guest.name

    respond_to do |format|
      if @booking.save
        @event = Event.find_by_booking_id(@booking)
        format.json { render json: @event.as_json, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.json
  def update
    @booking = Booking.find(params[:id])

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    respond_to do |format|
        format.json { render json: {:event_id => @booking.event.id}}
    end
  end



  def find_available_rooms

    params[:start_date] && params[:end_date] ?
        @rooms = Room.open_days(Date.parse(params[:start_date]), Date.parse(params[:end_date])) :
        @rooms = Room.all


    respond_to do |format|
        format.json { render json: @rooms }
    end



  end

end
