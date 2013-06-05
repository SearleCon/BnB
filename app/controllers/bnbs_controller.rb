class BnbsController < ApplicationController
  respond_to :html, :json, :js

  load_and_authorize_resource :bnb

  # GET /bnbs
  # GET /bnbs.json
  def index
    params[:q] ||= {}
    @search = Bnb.approved.search(params[:q])
    @bnbs = @search.result.select([:id, :name, :description, :city, :rating, :slug]).paginate(per_page: 15, page: params[:page])

  end

  # GET /bnbs/1
  # GET /bnbs/1.json
  def show
     redirect_to startpage_url and return unless @bnb
     convert_to_map_data(@bnb) if @bnb.mappable?
  end

  def nearby_bnbs
   if @bnb.nearbys
     params[:q] ||= {}
     @search = @bnb.nearbys(10).search(params[:q])
     @bnbs = @search.result.paginate(per_page: 5, page: params[:page])
     render :index
    else
     redirect_to show_bnb_url(@bnb), alert: "No bnbs were found nearby"
   end
  end

  def edit
    redirect_to bnb_setup_wizard_url(@bnb)
  end

  def create
    @bnb = Bnb.create! do |bnb|
      bnb.user_id = current_user.id
      bnb.contact_person = "#{current_user.name} #{current_user.surname}".titleize
      bnb.email = current_user.email
      bnb.telephone_number = current_user.contact_number
    end
    redirect_to bnb_setup_wizard_url(@bnb)
  end

  def update
   @bnb.update_attributes(params[:bnb])
   respond_with(@bnb)
  end

  private
  def convert_to_map_data(bnb)
    @map_data = bnb.to_gmaps4rails do |data ,marker|
      marker.title "#{data.name}"
      marker.infowindow render_to_string(partial: "/bnbs/mapinfo", locals: { bnb: data})
    end
  end

end
