class BookingsController < ApplicationController
  respond_to :js, :html, :json
  before_filter :authenticate_user!, only: :confirm
  load_and_authorize_resource :bnb, only: [:new, :create, :index]
  load_and_authorize_resource :booking, through: :bnb, only: [:new, :create]
  load_and_authorize_resource :booking, except: [:new, :create, :index]

  authorize_resource only: :index

  cache_sweeper :bookings_sweeper

  caches_action :show

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
    @booking.update_attributes(params[:booking])
    respond_with(@booking, location: bnb_bookings_url(@booking.bnb))
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def check_in
    @booking.update_attributes(status: :checked_in)
    respond_with(@booking, location: bnb_bookings_url(@booking.bnb))
  end

  def check_out
    if @booking.check_out
      redirect_to show_invoice_booking_url(@booking)
    else
      redirect_to bnb_bookings_url(@bnb), alert: "This booking could not be checked out."
    end
  end

  def cancel_check_out
    if @booking.update_attributes(status: :checked_in)
      redirect_to bnb_bookings_url(@booking.bnb), notice: 'Check out was cancelled successfully.'
    else
      redirect_to show_invoice_booking_url(@booking), alert: "Cancellation failed."
    end
  end

  def close
    if @booking.update_attributes(status: :closed, active: false)
      redirect_to bnb_bookings_url(@booking.bnb), notice: 'Booking has been closed successfully.'
    else
      redirect_to show_invoice_booking_url(@booking), alert: "The booking could not be closed."
    end
  end

  def refresh_total
    respond_with(@booking)
  end

  def print_invoice
    @pdf = render_to_string pdf: @booking.guest.name,
                            template: 'bookings/invoice.pdf.erb',
                            header: {center: "Invoice", right: Time.now.strftime('%A, %d %B %Y')},
                            encoding: "UTF-8"
    respond_to do |format|
      format.pdf { send_data(@pdf, filename: @booking.guest.name, type: "application/pdf", disposition: 'inline') }
    end
  end


  def confirm
    UserMailer.delay.confirmation_received(@booking) if @booking.update_attributes(status: :booked)
    respond_with(@booking, location: bnb_bookings_url(@bnb))
  end
end
