class PhotosController < ApplicationController



  def index
    @bnb = Bnb.find(params[:bnb_id])
    get_photos
  end

  def new
    @bnb = Bnb.find(params[:bnb_id])
    @photo = @bnb.photos.new

    respond_to do |format|
     format.html
    end

  end

  def create
    @bnb = Bnb.find(params[:bnb_id])
    @photo = @bnb.photos.build(params[:photo])

    if @photo.save
      get_photos
      redirect_to bnb_photos_url(@bnb)
    else
      redirect_back_or root_path
    end

  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.remove_image!
    @photo.destroy
    respond_to do |format|
      format.js { @photo }
    end
  end

    private
    def get_bnb
      @bnb = Bnb.find_by_user_id(current_user)
    end

    def get_photos
      @photos = Photo.find_all_by_bnb_id(@bnb)
    end
end