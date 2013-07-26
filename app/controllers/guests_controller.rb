class GuestsController < ApplicationController
  respond_to :html, :js,:json

  load_and_authorize_resource :bnb, only: [:index, :new, :create]
  load_and_authorize_resource :guest, through: :bnb, only: [:index, :new, :create]
  load_and_authorize_resource :guest, except: [:index, :new, :create]



  # GET /guests
  # GET /guests.json
  def index
    @guests = @guests.search(name_cont: params[:search]).result.paginate(per_page: 15, page: params[:page])
    respond_with(@guests)
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
    respond_with(@guest, location: bnb_guests_url(@guest.bnb))
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest.destroy
    respond_with(@guest)
  end

  private

  def interpolation_options
    { resource_name: @guest.full_name }
  end
end
