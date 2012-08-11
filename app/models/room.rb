# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  description :string(255)
#  en_suite    :boolean
#  rates       :decimal(, )
#  extras      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bnb_id      :integer
#  room_number :integer
#  available   :boolean          default(TRUE)
#  capacity    :integer          default(2)
#

class Room < ActiveRecord::Base
  belongs_to :bnb

  has_and_belongs_to_many :bookings
  has_many  :guests, :through => :bookings


  scope :has_en_suite, where(:en_suite => true)


end
