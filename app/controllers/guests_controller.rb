class GuestsController < ApplicationController
  respond_to :json, :js, :html

  load_and_authorize_resource :bnb
  load_and_authorize_resource :guest, :through => :bnb

  helper_method :sort_column, :sort_direction

  after_filter :expire_cached_index, :only => :destroy

  caches_action :index, :cache_path => proc {|c|
    key = Guest.maximum(:updated_at)
    unless key.nil?
      c.params.merge!(:tag => key.to_i )
    end
  }


  # GET /guests
  # GET /guests.json
  def index
    @guests = Guest.search(params[:search]).where('bnb_id = ?', @bnb.id).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = @bnb.guests.new do |guest|
      guest.name = 'Joe'
      guest.surname = 'Soap'
      guest.contact_number = '0123456789'
      guest.email = 'JoeSoap@example.com'
      guest.user_id = current_user.id
    end
    flash.now[:error] = "An error occurred while creating a guest." unless  @guest.save
    respond_with(@guest)
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest.update_attributes(params[:guest])
    respond_with_bip(@guest)
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

  def expire_cached_index
    expire_action :action => :index, :tag => Guest.maximum(:updated_at).to_i
  end
end
