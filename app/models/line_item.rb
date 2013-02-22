# == Schema Information
#
# Table name: line_items
#
#  id          :integer          not null, primary key
#  description :string(255)
#  value       :decimal(, )
#  booking_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LineItem < ActiveRecord::Base
  belongs_to :booking

  validates_presence_of :value
end
