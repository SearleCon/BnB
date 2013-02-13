class PhotosController < ApplicationController
  load_and_authorize_resource :bnb
  load_and_authorize_resource :photo, :through => :bnb


  def index
    @photos = @bnb.photos.where(:processed => true)
  end

  def new
    @photo = @bnb.photos.new
  end

  def edit
  end

  def create
    @photo = @bnb.photos.build(params[:photo])
    @photo.image.success_action_redirect = process_image_bnb_photo_url(@bnb, @photo) if @photo.save

    respond_to do |format|
      format.js  { render layout: false }
    end
  end

  def update
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to bnb_photos_url(@bnb), notice: 'Photo was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end

  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.js { render layout: false}
    end
  end

  def process_image
    @photo.key = params[:key]
    @photo.save_and_process_image
    respond_to do |format|
      format.html { redirect_to bnb_photos_url(@bnb) }
    end
  end
end