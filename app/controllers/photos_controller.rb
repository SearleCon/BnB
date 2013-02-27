class PhotosController < ApplicationController
  respond_to :js, :html
  prepend_before_filter :load_resources, :only => :index
  prepend_before_filter :new_resource, :only => [:new, :create]
  prepend_before_filter :load_resource, :only => [:edit,:update, :process_image, :destroy]
  prepend_before_filter :load_parent
  authorize_resource


  def create
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
      @photo.remote_image_url = @photo.image.direct_fog_url(:with_path => true)
      if @photo.valid?
        @photo.save_and_process_image(:now => false)
        redirect_to bnb_photos_url(@bnb), notice: "Image is being processed."
      else
        @photo.remove_image!
        render 'upload', alert: "There was an error processing the image."
      end
  end

  private
  def load_parent
    @bnb = Bnb.find(params[:bnb_id])
  end

  def new_resource
   Photo.unscoped { @photo = @bnb.photos.new(params[:photo]) }
  end

  def load_resource
    Photo.unscoped { @photo = @bnb.photos.find(params[:id]) }
  end

  def load_resources
    @photos = @bnb.photos.scoped
  end
end