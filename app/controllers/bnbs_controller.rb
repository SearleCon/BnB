class BnbsController < ApplicationController
  respond_to :html, :json, :js

  load_and_authorize_resource :bnb, except: :subregions

  # GET /bnbs
  # GET /bnbs.json
  def index
    params[:q] ||= {}
    @search = Bnb.approved.search(params[:q])
    @bnbs = @search.result.paginate(per_page: 15, page: params[:page])
  end

  # GET /bnbs/1
  # GET /bnbs/1.json
  def show
    redirect_to startpage_url and return unless @bnb
    to_gmaps_json(@bnb) if @bnb.mappable?
  end

  def nearby_bnbs
  params[:q] ||= {}
  @search = @bnb.nearbys(10).search(params[:q])
  @bnbs = @search.result.paginate(per_page: 5, page: params[:page]) if @bnb.nearbys
    if @bnbs.try(:any?)
      convert_to_map_data(@bnbs.reject{|bnb| valid_address(bnb.full_address)})
      render 'index'
    else
      flash[:alert] = "No bnbs were found nearby"
      redirect_to show_bnb_url(@bnb)
    end
  end


  # POST /bnbs
  # POST /bnbs.json
  def create
    @bnb = Bnb.new(user_id: current_user.id)
    if @bnb.save(validate: false)
      redirect_to  bnb_bnb_step_url(:bnb_details, bnb_id: @bnb.id)
    else
      flash[:alert] = 'An error occurred while initializing bnb setup wizard'
      redirect_to startpage_url
    end
  end

  # PUT /bnbs/1
  # PUT /bnbs/1.json
  def update
   @bnb.update_attributes(params[:bnb])
   respond_with(@bnb)
  end

  # DELETE /bnbs/1
  # DELETE /bnbs/1.json
  def destroy
    @bnb.destroy
  end


  private
  def convert_to_map_data(bnbs)
    if bnbs.any?
      @json = bnbs.to_gmaps4rails do |bnb, marker|
        marker.title "#{bnb.name}"
        marker.infowindow render_to_string(partial: "/bnbs/mapinfo", :locals => { :bnb => bnb})
      end
    else
      @json = nil
    end
  end

  def to_gmaps_json(bnb)
    @json = bnb.to_gmaps4rails
  end

end
