class PhotosController < ApplicationController

  def index
    @bnb = Bnb.find(params[:bnb_id])
    @photos = @bnb.photos
  end

  def new
    @bnb = Bnb.find(params[:bnb_id])
    @photo = Photo.new

    respond_to do |format|
     format.html
    end

  end

  def create
    @bnb = Bnb.find(params[:bnb_id])
    @photo = @bnb.photos.build(params[:photo])

    if @photo.save
      @photos = @bnb.photos.reload
      redirect_to bnb_photos_url(@bnb)
    else
      redirect_back_or root_path
    end

  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.js { @photo }
    end
  end
end