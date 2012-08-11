# == Schema Information
#
# Table name: guests
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  surname        :string(255)
#  contact_number :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Guest < ActiveRecord::Base
  has_many :bookings
  has_many :rooms, :through => :bookings
end
