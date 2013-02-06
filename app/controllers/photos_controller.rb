class PhotosController < ApplicationController

  def index
    @bnb = Bnb.find(params[:bnb_id])
    @photos = @bnb.photos
    @uploader = Photo.new.image
    @uploader.success_action_redirect = new_bnb_photo_url(@bnb)
  end

  def new
    @bnb = Bnb.find(params[:bnb_id])
    @photo = @bnb.photos.new(key: params[:key])

    respond_to do |format|
     format.html
    end

  end

  def create
    @bnb = Bnb.find(params[:bnb_id])
    @photo = @bnb.photos.build(params[:photo])

    @photo.save
    respond_to do |format|
      format.js  { render layout: false }
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.js { render layout: false}
    end
  end

end