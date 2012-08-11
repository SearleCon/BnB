# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  description :string(255)
#  image       :string(255)
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bnb_id      :integer
#

class Photo < ActiveRecord::Base
  belongs_to :bnb
  mount_uploader :image, ImageUploader
end
