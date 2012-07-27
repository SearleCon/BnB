class Photo < ActiveRecord::Base
  belongs_to :bnb
  mount_uploader :image, ImageUploader
end
