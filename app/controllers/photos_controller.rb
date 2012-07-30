class PhotosController < ApplicationController
  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
     @bnb = Bnb.last
     redirect_back_or root_path
    else
      redirect_back_or root_path

    end

  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.remove_image!
    @photo.destroy
    @bnb = Bnb.last
  end
end