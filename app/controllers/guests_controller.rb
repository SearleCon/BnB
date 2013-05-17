class GuestsController < ApplicationController
  respond_to :json, :js, :html

  load_and_authorize_resource :bnb, only: [:index, :new, :create]
  load_and_authorize_resource :guest, through: :bnb, only: [:index, :new, :create]
  load_and_authorize_resource :guest, except: [:index, :new, :create]


  helper_method :sort_column, :sort_direction

  # GET /guests
  # GET /guests.json
  def index
    @guests = Guest.where(bnb_id: @bnb.id).search(name_cont: params[:search]).result.order(sort_column + " " + sort_direction).paginate(per_page: 15, page: params[:page])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest.user_id = current_user.id
    @guest.save
    respond_with(@guest, location: bnb_guests_url(@bnb))
  end


  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest.update_attributes(params[:guest])
    respond_with(@guest, location: bnb_guests_url(@bnb))
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest.destroy
    respond_with(@guest)
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Guest.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def interpolation_options
    { resource_name: @guest.full_name }
  end
end
