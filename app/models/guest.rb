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
#  bnb_id         :integer
#  user_id        :integer
#

class Guest < ActiveRecord::Base
  belongs_to :bnb
  has_many :bookings
  has_many :rooms, :through => :bookings

  scope :search_by_name, lambda { |term|
    order(:name).where("name like ?", "%#{term}%")
  }

end
