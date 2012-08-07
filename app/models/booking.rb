class Booking < ActiveRecord::Base
  belongs_to :guest
  belongs_to :room
  has_one :event

  accepts_nested_attributes_for :event

end
