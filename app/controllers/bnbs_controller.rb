class BnbsController < ApplicationController
  load_and_authorize_resource :bnb, :except => :subregions



  # GET /bnbs
  # GET /bnbs.json
  def index
    @search = Search.new(params[:search])
    if !@search.city.nil?
      @bnbs = Bnb.where("city like ?", "%#{@search.city}%").paginate(:per_page => 5, :page => params[:page])
    elsif !@search.region.nil?
      @bnbs = Bnb.where("region like ?", "%#{@search.region}%").paginate(:per_page => 5, :page => params[:page])
    else
      @bnbs = Bnb.where("country like ?", "%#{@search.country}%").paginate(:per_page => 5, :page => params[:page])
    end


    @json = @bnbs.to_gmaps4rails do |bnb, marker|
      marker.title "#{bnb.name}"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bnb}
    end
  end

  # GET /bnbs/1
  # GET /bnbs/1.json
  def show
    @bnb = Bnb.includes(:photos).find_by_user_id(current_user) if @bnb.nil?
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bnb }
    end
  end

  # GET /bnbs/new
  # GET /bnbs/new.json
  def new
    @bnb = Bnb.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bnb }
    end
  end

  # GET /bnbs/1/edit
  def edit
    @bnb = Bnb.find(params[:id])
  end

  # POST /bnbs
  # POST /bnbs.json
  def create
    @bnb = Bnb.new
    @bnb.status = 'inactive'
    @bnb.user_id = current_user.id
      if @bnb.save
        redirect_to  bnb_bnb_step_path(:bnb_details, :bnb_id => @bnb.id)
      else
        format.html { render action: "new" }
        format.json { render json: @bnb.errors, status: :unprocessable_entity }
      end
  end

  # PUT /bnbs/1
  # PUT /bnbs/1.json
  def update
    respond_to do |format|
      if @bnb.update_attributes(params[:bnb])
        format.html { redirect_to @bnb, notice: 'Bnb was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bnb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bnbs/1
  # DELETE /bnbs/1.json
  def destroy
    @bnb.destroy

    respond_to do |format|
      format.html { redirect_to bnbs_url }
      format.json { head :no_content }
    end
  end


  def subregions
      regions = render_to_string  partial: 'shared/select_region', parent_region: params[:parent_region]
      regions = regions.html_safe.gsub(/[\n\t\r]/, '')
      render :json => {:html => regions, :error => '' }
  end
end
