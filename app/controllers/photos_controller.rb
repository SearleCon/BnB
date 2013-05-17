class PhotosController < ApplicationController
  respond_to :js, :html
  prepend_before_filter :load_resources, only: :index
  prepend_before_filter :new_resource, only: [:new, :create]
  prepend_before_filter :load_resource, only: [:edit,:update, :process_image, :destroy]
  prepend_before_filter :load_parent, only: [:new, :create, :index]
  authorize_resource


  def create
    @photo.image.success_action_redirect = process_image_photo_url(@photo) if @photo.save
    respond_with(@photo)
  end

  def update
  @photo.update_attributes(params[:photo])
  respond_with(@photo, location: bnb_photos_url(@photo.bnb))
  end

  def destroy
    @photo.destroy
    respond_with(@photo, location: bnb_photos_url(@photo.bnb))
  end

  def process_image
      @photo.key = params[:key]
      if @photo.valid?
        @photo.save_and_process_image(now: false)
        redirect_to bnb_photos_url(@photo.bnb), notice: "Image is being processed."
      else
        @photo.destroy
        render 'photos/upload'
      end
  end

  private
  def load_parent
    @bnb = Bnb.find(params[:bnb_id])
  end

  def new_resource
    @photo = @bnb.photos.new(params[:photo])
  end

  def load_resource
    @photo = Photo.find(params[:id])
  end

  def load_resources
    @photos = @bnb.photos.processed.includes(:bnb)
  end
end