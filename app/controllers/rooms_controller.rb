class RoomsController < ApplicationController
  respond_to :js, :json, :html

  load_and_authorize_resource :bnb, :find_by => :slug, :parent => true
  load_and_authorize_resource :room, :through => :bnb

  helper_method :sort_column, :sort_direction
  after_filter :expire_cached_index, :only => :destroy


  caches_action :index, :cache_path => proc {|c|
    key = Room.maximum('updated_at')
    c.params.merge! :tag => key.to_i  if key
  }

  # GET /rooms
  # GET /rooms.json
  def index
    search_term = params[:search].to_s.downcase if params[:search]
    @rooms = Room.search(search_term).where('bnb_id = ?', @bnb.id).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
  end

  def new
    @room.rates = @bnb.standard_rate
  end

  # POST /rooms
  # POST /rooms.json
  def create
    flash[:notice] = "#{@room.room_number} was created successfully" if @room.save
    respond_with(@room, :location => bnb_rooms_url(@bnb))
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    flash[:notice] = "#{@room.room_number} was updated successfully" if @room.update_attributes(params[:room])
    respond_with(@room, :location => bnb_rooms_url(@bnb))
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    flash.now[:error] = "An error occured. The room could not be destroyed." unless @room.destroyed?
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

  def expire_cached_index
    expire_action :action => :index, :tag => Room.maximum(:updated_at).to_i
  end

end
