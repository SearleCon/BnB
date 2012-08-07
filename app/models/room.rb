class Room < ActiveRecord::Base
  belongs_to :bnb

  has_many  :bookings
  has_many  :guests, :through => :bookings


  scope :has_en_suite, where(:en_suite => true)


end
