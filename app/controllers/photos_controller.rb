class PhotosController < ApplicationController
  respond_to :js, :html
  load_and_authorize_resource :bnb
  load_and_authorize_resource :photo, :through => :bnb


  def index
    @photos = @bnb.photos.where(:processed => true)
  end

  def new
    @photo = @bnb.photos.new
  end

  def create
    @photo = @bnb.photos.build(params[:photo])
    @photo.image.success_action_redirect = process_image_bnb_photo_url(@bnb, @photo) if @photo.save
    respond_with(@photo)
  end

  def update
    if @photo.update_attributes(params[:photo])
      flash[:notice] = 'Photo was updated successfully'
      redirect_to bnb_photos_url(@bnb)
    else
      render 'edit'
    end



  end

  def destroy
    @photo.destroy
    flash.now[:error] = "Photo could not be destroyed." unless @photo.destroyed?
    respond_with(@photo)
  end

  def process_image
    @photo.key = params[:key]
    @photo.save_and_process_image
    redirect_to bnb_photos_url(@bnb), notice: "Image is being processed."
  end
end