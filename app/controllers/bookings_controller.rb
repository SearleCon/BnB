class BookingsController < ApplicationController
  respond_to  :js, :html, :json
  load_and_authorize_resource :bnb, :except => [:my_bookings]
  load_and_authorize_resource :booking, :through => :bnb, :except => [:my_bookings, :index]
  authorize_resource :only => [:my_bookings, :index]

  before_filter :expire_cached_action, :only => :destroy

  helper_method :sort_column, :sort_direction

  caches_action :show, :cache_path => proc {|c|
    key = Booking.find(c.params[:id]).updated_at
    { :tag => key.to_i } if key
  }

  caches_action :my_bookings, :cache_path => proc {|c|
    key = Booking.where(:user_id => current_user.id).maximum(:updated_at)
    c.params.merge! :tag => key.to_i if key
  }

  # GET /my_bookings
  def my_bookings
      active = Booking.includes([:event, :bnb]).where(:user_id => current_user).search(params[:search]).order(sort_column + " " + sort_direction)
      @active_bookings = active.paginate(:per_page => 15, :page => params[:active_page]) if active
      inactive = Booking.inactive.includes([:event, :bnb]).where(:user_id => current_user).search(params[:search]).order(sort_column + " " + sort_direction)
      @inactive_bookings = inactive.paginate(:per_page => 15, :page => params[:inactive_page]) if inactive
  end
  # GET /bookings/1
  # GET /bookings/1.json
  def show
    respond_with(@booking)
  end

  # GET /bookings/new
  # GET /bookings/new.json
  def new
    @booking = @bnb.bookings.build(:online => current_user.is?(:guest)) do |booking|
      booking.build_event(:start_at => params[:date])
      booking.build_guest(:name => current_user.name, :surname => current_user.surname, :email => current_user.email, :contact_number => current_user.contact_number) if current_user.is?(:guest)
    end
  end


  # POST /bookings
  # POST /bookings.json
  def create
    @booking = @bnb.bookings.build(params[:booking]) do |booking|
      booking.user_id = current_user.id
      booking.try(:guest).user_id = current_user.id if booking.guest.try(:new_record?)
      booking.rooms = Room.find(params[:room_ids]) if params[:room_ids]
      booking.status = :booked unless booking.online?
    end

    @booking.save
    respond_with(@booking, :location => get_correct_user_response  )

  end

  # PUT /bookings/1
  # PUT /bookings/1.json
  def update
    @booking.rooms = Room.find(params[:room_ids]) if params[:room_ids]
    if @booking.update_attributes(params[:booking])
     flash.now[:notice] = "Booking was successfully updated." if request.xhr?
    else
      flash.now[:alert] = "Booking could not be updated." if request.xhr?
    end
    respond_with(@booking, :location => get_correct_user_response )

  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    flash.now[:alert] = 'Booking could not be destroyed' if @booking.destroyed?
    respond_with(@booking)
  end

 def check_out
   @booking.rooms.each do |room|
     @line_item = @booking.line_items.build
     @line_item.description = room.room_number
     @line_item.value = room.rates * number_of_nights
   end
   if @booking.save
     redirect_to show_invoice_bnb_booking_url(@bnb,@booking)
   else
     redirect_to bnb_bookings_url(@bnb), :alert => "This booking could not be checked out."
   end
 end

 def cancel_check_out
   @booking.status = :checked_in
   @booking.active = true
   @booking.line_items.destroy_all
   if @booking.save
     redirect_to bnb_bookings_url(@bnb), :notice => 'Check out process was cancelled successfully.'
   else
     flash[:alert] = "Cancellation failed."
     redirect_to show_invoice_bnb_booking_url(@bnb,@booking)
   end
 end

  def complete_check_out
    @booking.status = :closed
    @booking.active = false
    if @booking.save
      redirect_to bnb_bookings_url(@bnb), :notice => 'Booking has been checked out successfully.'
    else
      flash[:alert] = "The check out process could not be completed."
      redirect_to show_invoice_bnb_booking_url(@bnb,@booking)
    end
  end

 def tabular_view
   @bookings = @bnb.bookings.search(params[:search]).order(sort_column + " " + sort_direction)
 end

 def refresh_total
   respond_with(@booking)
 end

 def print_pdf
   @pdf = render_to_string :pdf => @booking.guest.name,
                           :template => 'bookings/invoice.pdf.erb',
                           :header => { center: "Invoice", right: Time.now.strftime('%A, %d %B %Y') },
                           :encoding => "UTF-8"
   respond_to do |format|
     format.pdf { send_data(@pdf, :filename => @booking.guest.name,  :type=>"application/pdf", :disposition => 'inline') }
   end
 end

def show_invoice
  @bnb = Bnb.find(params[:bnb_id])

  Booking.unscoped {@booking = @bnb.bookings.find(params[:id])}
end

 private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Booking.column_names.include?(params[:sort]) ? params[:sort] : "bnb_id"
  end

  def number_of_nights
   total ||= (Date.parse(@booking.event.end_at) - Date.parse(@booking.event.start_at)).to_i
  end

  def expire_cached_action
    expire_action :controller => '/events', :action => 'index', :tag => current_user.bnb.bookings.maximum(:updated_at).to_i
    expire_action :action => :my_bookings, :tag => Booking.where(:user_id => current_user.id).maximum(:updated_at).to_i
  end

  def get_correct_user_response
    current_user.is?(:owner) ? bnb_bookings_url(@bnb) : my_bookings_bookings_url
  end

end
