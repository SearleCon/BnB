class PhotosController < ApplicationController
  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:success] = "Welcome to the Shell App!"
      redirect_to root_path
    else
      flash[:fail] = "Could not save photo"
      redirect_back_or root_path

    end

  end

  def destroy

  end
end
