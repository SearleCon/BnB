class GuestsController < ApplicationController
  load_and_authorize_resource :bnb
  load_and_authorize_resource :guest, :through => :bnb

  helper_method :sort_column, :sort_direction

  # GET /guests
  # GET /guests.json
  def index
    @bnb = Bnb.find(params[:bnb_id])
    @guests = params[:term] ? Guest.search_by_name(params[:term]).where("bnb_id = ?", @bnb.id) :  @guests = Guest.search(params[:search]).where('bnb_id = ?', @bnb.id).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @guests.map(&:name) }
    end

  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/othernew
  # GET /guests/othernew.json
  def new
    @guest = Guest.new

    respond_to do |format|
      format.html # othernewernew.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
  end

  # POST /guests
  # POST /guests.json
  def create
    @bnb = Bnb.find(params[:bnb_id])
    @guest = @bnb.guests.new(params[:guest])
    create_default_guest
    respond_to do |format|
      if @guest.save
        format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        format.js { @guest }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find(params[:id])

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to @guest, notice: 'Guest was successfully updated.' }
        format.json { respond_with_bip(@guest) }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to guests_url }
      format.js { @guest }
      format.json { head :no_content }
    end
  end

  def create_default_guest
    @guest.name = 'Joe'
    @guest.surname = 'Soap'
    @guest.contact_number = '123456789'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Guest.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end
