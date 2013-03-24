# == Schema Information
#
# Table name: line_items
#
#  id          :integer          primary key
#  description :string(255)
#  value       :decimal(, )
#  booking_id  :integer
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

class LineItem < ActiveRecord::Base
  belongs_to :booking

  attr_accessible :description, :value

  validates_presence_of :value
end
