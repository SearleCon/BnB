# encoding: utf-8
require 'carrierwave/processing/mime_types'
require "securerandom"
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader


  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick


  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
   include Sprockets::Helpers::RailsHelper
   include Sprockets::Helpers::IsolatedHelper

   include CarrierWave::MimeTypes
   process :set_content_type

  process :strip
  #process :resize_to_fill => [200, 200]
  process :quality => 70 # Set JPEG/MIFF/PNG compression level (0-100)
  #process :convert => 'png'

   process :resize_to_limit => [640, 480]

  version :thumb do
    process :resize_to_fit => [350, 350]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def filename
    if original_filename
      if model && model.read_attribute(mounted_as).present?
        model.read_attribute(mounted_as)
      else
        @name ||= "#{mounted_as}-#{uuid}.#{file.extension}"
      end
    end
  end

  protected

  def uuid
    SecureRandom.hex(9)
  end

end
