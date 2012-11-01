class BookingsController < ApplicationController
  load_and_authorize_resource :bnb, :except => :my_bookings
  load_and_authorize_resource :booking, :through => :bnb, :except => :my_bookings

  helper_method :sort_column, :sort_direction

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.find_all_by_bnb_id(@bnb)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookings }
    end
  end

  # GET /my_bookings
  def my_bookings

    @active_bookings = Booking.active_bookings_by_user(current_user).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:active_page])

    @inactive_bookings = Booking.inactive_bookings_by_user(current_user).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:inactive_page])

    respond_to do |format|
      format.html
    end

  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
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
  # GET /bookings/8new.json
  def new
    @booking = Booking.new
    @booking.build_event
    @booking.build_guest
    params[:date] ? selected_day = Date.parse(params[:date]) : selected_day = Date.today
    @booking.event.start_at = selected_day.strftime('%A, %d %B %Y')
    @booking.event.end_at = (selected_day + 1.days).strftime('%A, %d %B %Y')

    if request.xhr?
      event_details = render_to_string :partial => 'bookings/form', locals: { booking: @booking }
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
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = @bnb.bookings.new(params[:booking])
    @booking.event.name = @booking.guest_name
    @booking.user_id = current_user.id
    if current_user.role.description == "Owner"
      @booking.status = :booked
    end

    respond_to do |format|
      if @booking.save
        if current_user.role.description == "Guest"
          UserMailer.delay.booking_made(current_user, @booking)
          UserMailer.delay.notify_bnb(@booking)
        end
        @event = Event.find_by_booking_id(@booking)
        format.html { redirect_to my_bookings_bookings_url, notice: 'Booking was created' }
        format.json { render json: @event.as_json, status: :created, location: @event,  notice: 'Booking was created'}
      else
        format.html  do
          if request.xhr?
            event_details = render_to_string :partial => 'shared/error_messages', locals: { object: @booking}
            event_details = event_details.html_safe.gsub(/[\n\t\r]/, '')
            render :json =>  event_details , status: :unprocessable_entity
          else
            render 'bookings/client_booking_form'
          end
        end
      end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.json
  def update
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
    @booking.destroy
    respond_to do |format|
        format.json { render json: {:event_id => @booking.event.id, :booking_id => @booking.id}}
    end
  end

  def check_in
    @booking.update_attribute(:status, :checked_in)
    respond_to do |format|
      format.html {redirect_to bookings_url}
      format.js { @booking }
    end
  end

  def show_invoice

  end

 def check_out
   @booking.status = :closed
   @booking.rooms.each do |room|
     @line_item = @booking.line_items.build
     @line_item.description = room.room_number
     @line_item.value = room.rates
   end
   if @booking.save
     respond_to do |format|
       format.html { redirect_to show_invoice_bnb_booking_url(@bnb,@booking)}
       format.json { render json: @booking}
     end
   end
 end

 def confirm
   @booking.update_attribute(:status, :booked)
   UserMailer.deliver_confirmation_received.delay(@booking)
   respond_to do |format|
     format.js { @booking }
   end
 end

 def refresh_total
   respond_to do |format|
     format.js { @booking }
   end
 end

 def print_pdf
   respond_to do |format|
     format.pdf do
       @pdf = render_to_string :pdf => @booking.guest_name,
              :template => 'bookings/invoice.pdf.erb',
              :header => { center: "Invoice", right: Time.now.strftime('%A, %d %B %Y') },
              :encoding => "UTF-8"

       send_data(@pdf, :filename => @booking.guest_name,  :type=>"application/pdf")
     end
   end
 end

 private
 def get_bnb
    params[:bnb_id]  ? @bnb = Bnb.find(params[:bnb_id]) : @bnb = Bnb.find_by_user_id(current_user)
 end

 def get_booking
   if params[:id]
     @booking = Booking.find(params[:id])
   end
 end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Booking.column_names.include?(params[:sort]) ? params[:sort] : "bnb_id"
  end

end
