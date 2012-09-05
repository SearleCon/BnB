class BnbsController < ApplicationController
  # GET /bnbs
  # GET /bnbs.json
  def index
    @bnbs = Bnb.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bnb}
    end
  end

  # GET /bnbs/1
  # GET /bnbs/1.json
  def display
    @bnb = Bnb.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @bnb }
    end
  end

  # GET /bnbs/1
  # GET /bnbs/1.json
  def show
    @bnb = Bnb.find(params[:id])

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
    @bnb = Bnb.find(params[:id])

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
    @bnb = Bnb.find(params[:id])
    @bnb.destroy

    respond_to do |format|
      format.html { redirect_to bnbs_url }
      format.json { head :no_content }
    end
  end
end
