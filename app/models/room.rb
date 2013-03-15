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

  validates :description, :rates, :room_number, :capacity, presence: true
  validates :rates, :room_number, :capacity, numericality: true
  validates :description, length: { minimum: 2 }

  scope :search, -> term { where('lower(description) LIKE ?', "%#{term}%") }
  scope :unbooked_rooms, -> start_date, end_date { where('id NOT IN (select id from rooms where id in (?))', Booking.includes(:event, :rooms).where('events.start_at <= ? AND events.end_at >= ?', end_date, start_date).collect(&:rooms).flatten.map(&:id)) }

end
