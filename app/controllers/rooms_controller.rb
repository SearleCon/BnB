class RoomsController < ApplicationController
  before_filter :get_bnb

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = @bnb.rooms

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end



  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
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
    @room = Room.find(params[:id])

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
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to bnb_rooms_path(@bnb) }
      format.js { @room }
      format.json { head :no_content }
    end
  end

  def find_available
    params[:start_date] && params[:end_date] ?
        @rooms = Room.booked(Date.parse(params[:start_date]),Date.parse(params[:end_date])).where(:bnb_id => @bnb.id) :
        @rooms = Room.find_all_by_bnb_id(@bnb.id)

    respond_to do |format|
      format.json { render json: @rooms }
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

end
