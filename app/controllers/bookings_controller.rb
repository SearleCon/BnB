class BookingsController < ApplicationController
     before_filter :get_bnb

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
    @bookings_to_check_in = Booking.needs_check_in(Date.today)
    @bookings_to_check_out = Booking.needs_check_out(Date.today)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookings }
    end
  end

  # GET /dashboard
  # GET /dashboard.json
  def dashboard
   @bookings_to_check_in = Booking.needs_check_in(Date.today)
   @bookings_to_check_out = Booking.needs_check_out(Date.today)

   respond_to do |format|
     format.html
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
    @booking.build_guest(name: current_user.name)

    params[:date] ? selected_day = Date.parse(params[:date]) : selected_day = Date.today
    @booking.event.start_at = selected_day.strftime('%A, %d %B %Y')
    @booking.event.end_at = (selected_day + 1.days).strftime('%A, %d %B %Y')
    @rooms = Room.find_all_by_bnb_id(@bnb.id)


    if request.xhr?
      event_details = render_to_string :partial => 'bookings/form'
      event_details = event_details.html_safe.gsub(/[\n\t\r]/, '')
      render :json => {:html => event_details, :error => '' }
    else
      respond_to do |format|
        format.html { render 'client_booking_form'}
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
        format.html { redirect_to @booking }
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
        format.json { render json: {:event_id => @booking.event.id, :booking_id => @booking.id}}
    end
  end

  def check_in
    @booking = Booking.find(params[:id])
    @booking.status = :checked_in
    @booking.save
    redirect_to :back
  end

 def check_out
   @booking = Booking.find(params[:id])
   @booking.status = :closed
   @booking.rooms.each do |room|
     @line_item = @booking.line_items.build
     @line_item.description = room.room_number
     @line_item.value = room.rates
   end
   if @booking.save
     respond_to do |format|
       format.html
       format.json { render json: @booking}
     end
   end
 end

 def confirm
   @booking = Booking.find(params[:id])
   @booking.status = :booked
   @booking.save
   redirect_to :back
 end



 def get_bnb
    params[:bnb_id]  ? @bnb = Bnb.find(params[:bnb_id]) : @bnb = Bnb.find_by_user_id(current_user)
 end

end
