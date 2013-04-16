class GuestsController < ApplicationController
  respond_to :json, :js, :html

  load_and_authorize_resource :bnb
  load_and_authorize_resource :guest, :through => :bnb

  helper_method :sort_column, :sort_direction


  # GET /guests
  # GET /guests.json
  def index
    search_term = params[:search].to_s.downcase if params[:search]
    @guests = Guest.search(search_term).where('bnb_id = ?', @bnb.id).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest.user_id = current_user
    flash[:notice] = "#{@guest.full_name} was created successfully" if @guest.save
    respond_with(@guest, location: bnb_guests_url(@bnb))
  end

  def edit
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    flash[:notice] = "#{@guest.full_name} was updated successfully" if @guest.update_attributes(params[:guest])
    respond_with(@guest, location: bnb_guests_url(@bnb))
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest.destroy
    flash.now[:error] = "An error occurred. The guest could not be destroyed." unless @guest.destroyed?
    respond_with(@guest)
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Guest.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end
