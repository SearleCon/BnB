# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  guest_id   :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Booking < ActiveRecord::Base
  belongs_to :guest
  has_and_belongs_to_many :rooms
  has_one :event

  accepts_nested_attributes_for :event

  def guest_name
    guest.try(:name)
  end

  def guest_name=(name)
    self.guest = Guest.find_or_create_by_name(name) if name.present?
  end

end
