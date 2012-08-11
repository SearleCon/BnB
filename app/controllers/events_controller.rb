class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.scoped

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    if request.xhr?
      event_details = render_to_string :partial => 'events/show', :locals => {:event => @event}
      event_details = event_details.html_safe.gsub(/[\n\t\r]/, '')
      render :json => {:html => event_details, :error => '' }
   else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }
      end
    end

  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @event.start_at = Date.parse(params[:date]).strftime("%Y-%m-%d")  if params[:date]
    @event.end_at = Date.parse(params[:date]).strftime("%Y-%m-%d").to_date + 2.days if params[:date]
    @event.end_at + 1.days

    if request.xhr?

      event_details = render_to_string :partial => 'events/form', :locals => {:event => @event}
      event_details = event_details.html_safe.gsub(/[\n\t\r]/, '')
      render :json => {:html => event_details, :error => '' }
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }
      end
    end

  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.json { render json: @event.as_json, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
     format.json { render json: {:event_id => @event.id}}
    end
  end
end
