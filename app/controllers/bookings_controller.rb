class BookingsController < ApplicationController
  load_and_authorize_resource :bnb, :except => :my_bookings
  load_and_authorize_resource :booking, :through => :bnb, :except => :my_bookings
  authorize_resource :only => :my_bookings

  helper_method :sort_column, :sort_direction

  caches_action :show, :cache_path => proc {|c|
    booking = Booking.find(c.params[:id])
    { :tag => booking.updated_at.to_i }
  }

  caches_action :my_bookings, :cache_path => proc {|c|
    booking = Booking.order('updated_at DESC').find_all_by_user_id(current_user.id).first
    unless booking.nil?
      c.params.merge!(:tag => booking.updated_at.to_i)
    end
  }


  # GET /my_bookings
  def my_bookings
    bookings = Booking.search(params[:search]).order(sort_column + " " + sort_direction).find_all_by_user_id(current_user)
    active = bookings.select{|booking| !booking.closed?}
    @active_bookings = active.paginate(:per_page => 15, :page => params[:active_page]) if active
    inactive = bookings.select{|booking| booking.closed?}
    @inactive_bookings = inactive.paginate(:per_page => 15, :page => params[:inactive_page]) if inactive
  end
  # GET /bookings/1
  # GET /bookings/1.json
  def show
      respond_to do |format|
        format.js { render layout: false }
      end
  end

  # GET /bookings/new
  # GET /bookings/new.json
  def new
    @booking = @bnb.bookings.build
    unless current_user.is?(:owner)
      @booking.build_guest(:name => current_user.name, :surname => current_user.surname, :email => current_user.email, :contact_number => current_user.contact_number)
    end
    @booking.build_event
    params[:date] ? selected_day = Date.parse(params[:date]) : selected_day = Date.today
    @booking.event.formatted_start_at(selected_day)
    @booking.event.formatted_end_at(selected_day + 1.days)

    respond_to do |format|
         format.html { render 'client_booking_form'}
         format.js { render layout: false }
    end
  end


  # POST /bookings
  # POST /bookings.json
  def create
    params[:booking].merge!(:user_id => current_user.id)
    @booking = @bnb.bookings.build(params[:booking])

    respond_to do |format|
      if @booking.save
        @event = Event.find_by_booking_id(@booking)
        format.html { redirect_to my_bookings_bookings_url, notice: 'Booking was created' }
        format.js { render layout: false }
      else
        format.html  { render 'bookings/client_booking_form' }
        format.js  { render layout: false }
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
    @event_id = @booking.event.id
    @booking.destroy
    respond_to do |format|
        format.js { render layout: false }
    end
  end

  def check_in
    @booking.update_attribute(:status, :checked_in)
    respond_to do |format|
      format.js { render layout: false }
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
     expire_action(action: :show, :id => @booking)
     respond_to do |format|
       format.html { redirect_to show_invoice_bnb_booking_url(@bnb,@booking)}
     end
   end
 end

 def confirm
   @booking.update_attribute(:status, :booked)
   respond_to do |format|
     format.js { render layout: false }
   end
 end

 def refresh_total
   respond_to do |format|
     format.js { render layout: false }
   end
 end

 def print_pdf
   respond_to do |format|
     format.pdf do
       @pdf = render_to_string :pdf => @booking.guest.name,
              :template => 'bookings/invoice.pdf.erb',
              :header => { center: "Invoice", right: Time.now.strftime('%A, %d %B %Y') },
              :encoding => "UTF-8"

       send_data(@pdf, :filename => @booking.guest.name,  :type=>"application/pdf")
     end
   end
 end

 private

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Booking.column_names.include?(params[:sort]) ? params[:sort] : "bnb_id"
  end

end
