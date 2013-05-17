class RoomsController < ApplicationController
  respond_to :js, :json, :html

  load_and_authorize_resource :bnb, find_by: :slug, only: [:new, :create, :index, :find_available ]
  load_and_authorize_resource :room, through: :bnb, only: [:new, :create, :index ]
  load_and_authorize_resource :room, except: [:new, :create, :index, :find_available]


  helper_method :sort_column, :sort_direction

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.where(bnb_id: @bnb.id).search(description_cont: params[:search]).result.order(sort_column + " " + sort_direction).paginate(per_page: 15, page: params[:page])
  end


  # POST /rooms
  # POST /rooms.json
  def create
    @room.save
    respond_with(@room, location: bnb_rooms_url(@bnb))
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room.update_attributes(params[:room])
    respond_with(@room, location: bnb_rooms_url(@room.bnb))
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_with(@room)
  end

  def find_available
     @booking = params[:booking_id] ? Booking.find(params[:booking_id]) : Booking.new
     @unbooked = @bnb.rooms.unbooked_rooms(Date.parse(params[:start_at]), Date.parse(params[:end_at])) + @booking.rooms
     respond_with(@unbooked)
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Room.column_names.include?(params[:sort]) ? params[:sort] : "description"
  end

  def interpolation_options
    { resource_name: @room.description }
  end


end
