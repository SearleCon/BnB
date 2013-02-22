class RoomsController < ApplicationController
  respond_to :js, :json, :html

  load_and_authorize_resource :bnb
  load_and_authorize_resource :room, :through => :bnb

  helper_method :sort_column, :sort_direction
  after_filter :expire_cached_index, :only => :destroy


  caches_action :index, :cache_path => proc {|c|
    key = Room.maximum('updated_at')
    unless key.nil?
     c.params.merge!(:tag => key.to_i )
    end
  }

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.search(params[:search]).where('bnb_id = ?', @bnb.id).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = @bnb.rooms.new do |room|
      room.description='Describe room'
      room.room_number=999
      room.en_suite=false
      room.rates= @bnb.standard_rate
      room.extras='none'
    end
    flash.now[:error] = "An error occurred while creating a room." unless @room.save
    respond_with(@room)
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room.update_attributes(params[:room])
    respond_with_bip(@room)
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    flash.now[:error] = "An error occured. The room could not be destroyed." unless @room.destroyed?
    respond_with(@room)
  end

  def find_available
    Booking.find(params[:booking_id]).rooms.destroy_all if params[:booking_id]
    @unbooked = @bnb.rooms.unbooked_rooms(Date.parse(params[:start_at]), Date.parse(params[:end_at]))

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
