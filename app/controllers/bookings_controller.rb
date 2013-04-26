class BookingsController < ApplicationController
  respond_to :js, :html, :json
  before_filter :authenticate_user!, only: :confirm
  load_and_authorize_resource :bnb
  load_and_authorize_resource :booking, through: :bnb, except: :index
  authorize_resource only: :index

  before_filter :expire_cached_action, :only => :destroy

  helper_method :sort_column, :sort_direction

  caches_action :show, cache_path: proc { |c|
    key = Booking.find(c.params[:id]).updated_at
    {tag: key.to_i} if key
  }


  # GET /bookings/1
  # GET /bookings/1.json
  def show
    respond_with(@booking)
  end

  # GET /bookings/new
  # GET /bookings/new.json
  def new
    @booking.build_event(start_at: params[:date])
    @booking.build_guest
  end


  # POST /bookings
  # POST /bookings.json
  def create
    @booking.user_id = current_user.id
    if @booking.guest.new_record?
      @booking.guest.user_id = current_user.id
      @booking.guest.bnb_id = @bnb.id
    end
    @booking.rooms = Room.find(params[:room_ids]) if params[:room_ids]
    @booking.status = :booked
    @booking.save
    respond_with(@booking, location: bnb_bookings_url(@bnb))
  end

  # PUT /bookings/1
  # PUT /bookings/1.json
  def update
    @booking.update_attributes(params[:booking]) ?
        flash.now[:notice] = "Booking was successfully updated." :
        flash.now[:alert] = "Booking could not be updated."
    respond_with(@booking, location: bnb_bookings_url(@bnb))
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    flash.now[:alert] = 'Booking could not be destroyed' unless @booking.destroyed?
    respond_with(@booking)
  end

  def check_out
     @booking.line_items.delete_all
     @line_item = @booking.line_items.build
     @line_item.description = @booking.rate.description
     @line_item.value = @booking.rate.price * number_of_nights
    if @booking.save
      redirect_to show_invoice_bnb_booking_url(@bnb, @booking)
    else
      redirect_to bnb_bookings_url(@bnb), alert: "This booking could not be checked out."
    end
  end

  def cancel_check_out
    @booking.status = :checked_in
    @booking.active = true
    if @booking.save
      redirect_to bnb_bookings_url(@bnb), :notice => 'Check out process was cancelled successfully.'
    else
      flash[:alert] = "Cancellation failed."
      redirect_to show_invoice_bnb_booking_url(@bnb, @booking)
    end
  end

  def complete_check_out
    @booking.status = :closed
    @booking.active = false
    if @booking.save
      redirect_to bnb_bookings_url(@bnb), :notice => 'Booking has been checked out successfully.'
    else
      flash[:alert] = "The check out process could not be completed."
      redirect_to show_invoice_bnb_booking_url(@bnb, @booking)
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
                            :header => {center: "Invoice", right: Time.now.strftime('%A, %d %B %Y')},
                            :encoding => "UTF-8"
    respond_to do |format|
      format.pdf { send_data(@pdf, :filename => @booking.guest.name, :type => "application/pdf", :disposition => 'inline') }
    end
  end


  def confirm
    if @booking.confirm!
      redirect_to bnb_bookings_url(@bnb), notice: "Booking for #{@booking.guest.name} was confirmed successfully"
    else
      redirect_to bnb_bookings_url(@bnb), alert: "Booking for #{@booking.guest.name} could not be confirmed"
    end
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
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
end
