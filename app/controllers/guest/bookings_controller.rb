class Guest::BookingsController < ApplicationController
  respond_to :html

  load_and_authorize_resource :bnb, except: :index
  load_and_authorize_resource :booking, through: :bnb, except: :index

  helper_method :sort_column, :sort_direction

  cache_sweeper :bookings_sweeper, only: [:create, :update]

  def index
    active = Booking.includes([:event, :bnb]).where(user_id: current_user).search(bnb_name_cont: params[:search]).result.order(sort_column + " " + sort_direction)
    @active_bookings = active.paginate(per_page: 15, page: params[:active_page]) if active
    inactive = Booking.inactive.includes([:event, :bnb]).where(user_id: current_user).search(bnb_name_cont: params[:search]).result.order(sort_column + " " + sort_direction)
    @inactive_bookings = inactive.paginate(per_page: 15, page: params[:inactive_page]) if inactive
  end

  def new
    @booking.build_event(start_at: params[:date])
    @booking.build_guest(name: current_user.name, surname: current_user.surname, email: current_user.email, contact_number: current_user.contact_number)
  end

  def create
    @booking.online = true
    @booking.user_id = current_user.id
    @booking.guest.user_id = current_user.id
    @booking.guest.bnb = @bnb
    @booking.rooms = Room.find(params[:room_ids]) if params[:room_ids]
    send_notifications(@booking) if @booking.save
    respond_with(@booking, location: guest_bookings_path)
  end

  def update
    @booking.update_attributes(params[:booking])
    respond_with(@booking, location: guest_bookings_path)
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Booking.column_names.include?(params[:sort]) ? params[:sort] : "bnb_id"
  end

  def send_notifications(booking)
    UserMailer.delay.booking_made(booking)
    UserMailer.delay.notify_bnb(booking)
  end

end
