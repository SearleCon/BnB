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

  attr_accessible :description, :main
  attr_accessor :filepath

  after_destroy :destroy_file

  validates :description, presence: true

  scope :find_main_photo, where(main: true)
  scope :find_support_photos, where(:main => false)


  def image_name
    File.basename(image.path || image.filename) if image
  end

  def save_and_process_image(options = {})
    if options[:now]
      self.remote_image_url = image.direct_fog_url(:with_path => true)
      save!
    else
      Delayed::Job.enqueue ProcessImageJob.new(self.attributes.merge(:key => self.key))
    end
  end


  private
  def destroy_file
   self.remove_image!
  rescue
    logger.info "Exception removing #{self.image_url}"
    return false
  end

end
