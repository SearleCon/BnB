# == Schema Information
#
# Table name: photos
#
#  id          :integer          primary key
#  description :string(255)
#  image       :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#  bnb_id      :integer
#  main        :boolean          default(FALSE)
#

class Photo < ActiveRecord::Base
  belongs_to :bnb
  mount_uploader :image, ImageUploader

  attr_accessor :filepath

  after_destroy :destroy_file

  validates :description, :image, presence: true

  scope :find_main_photo, where(main: true)
  scope :find_support_photos, where(:main => false)




  private
  def destroy_file
   self.remove_image!
  rescue
    logger.info "Exception removing #{self.image_url}"
    return false
  end

end
