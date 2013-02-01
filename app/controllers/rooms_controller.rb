class RoomsController < ApplicationController
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

    respond_to do |format|
      format.html
      format.json { render json: @rooms }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  def new
    @room = Room.new

    respond_to do |format|
      format.html
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = @bnb.rooms.new(params[:room])
    populate_default_room
    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.js { @room }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { respond_with_bip(@room) }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to bnb_rooms_path(@bnb) }
      format.js { @room }
      format.json { head :no_content }
    end
  end

  def find_available
    @booked_rooms = Room.booked(Date.parse(params[:start_date]),Date.parse(params[:end_date])).where(:bnb_id => @bnb.id)
    @rooms = Room.find_all_by_bnb_id(@bnb)
    @booked_rooms.nil? ? @unbooked = @rooms : @unbooked = @rooms.to_a - @booked_rooms.to_a
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
  def get_bnb
    @bnb = Bnb.find_by_user_id(current_user)
  end

  def populate_default_room
   @room.description='Describe room'
   @room.room_number=999
   @room.en_suite=false
   @room.rates=0
   @room.extras='none'
  end

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
