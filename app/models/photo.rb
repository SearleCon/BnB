# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  description :string(255)
#  image       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bnb_id      :integer
#  main        :boolean          default(FALSE)
#  processed   :boolean          default(FALSE)
#

class Photo < ActiveRecord::Base
  belongs_to :bnb
  default_scope  -> {where(:processed => true)}
  mount_uploader :image, ImageUploader

  attr_accessible :description, :main
  attr_accessor :filepath

  before_create :set_previous_main_to_false
  after_destroy :destroy_file


  validates :description, presence: true

  scope :main_photo, -> {where(main: true)}
  scope :support_photos, -> { where(:main => false) }

  def save_and_process_image(options = {})
    if options[:now]
      self.remote_image_url = image.direct_fog_url(:with_path => true)
      self.processed = true
      save!
    else
      Delayed::Job.enqueue ProcessImageJob.new(self.id, self.key)
    end
  end


  def remove_image!
    begin
      super
    rescue Fog::Storage::Rackspace::NotFound
    end
  end


  def remove_previously_stored_image
    begin
      super
    rescue Fog::Storage::Rackspace::NotFound
      @previous_model_for_image = nil
    end
  end

  private
  def set_previous_main_to_false
    Photo.main_photo.where(:bnb_id => self.bnb_id).first.try(:toggle!, :main)
  end

  def destroy_file
   self.remove_image!
  rescue
    logger.info "Exception removing #{self.image_url}"
    return false
  end


end
