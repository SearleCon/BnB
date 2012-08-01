class PhotosController < ApplicationController
    before_filter :get_bnb



  def index
    get_photos
  end

  def create
    @photo = @bnb.photos.new(params[:photo])
    if @photo.save
      get_photos
       redirect_to photos_path
    else
      redirect_back_or root_path
    end

  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.remove_image!
    @photo.destroy
    get_photos
  end

    private
    def get_bnb
      @bnb = Bnb.find_by_user_id(current_user)
    end

    def get_photos
      @photos = Photo.find_all_by_bnb_id(@bnb)
    end
end