# == Schema Information
#
# Table name: rooms
#
#  id          :integer          primary key
#  description :string(255)
#  en_suite    :boolean
#  rates       :decimal(, )
#  extras      :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#  bnb_id      :integer
#  room_number :integer
#  available   :boolean          default(TRUE)
#  capacity    :integer          default(2)
#

class Room < ActiveRecord::Base

  attr_accessible :description, :en_suite, :rates, :extras, :room_number, :available, :capacity

  belongs_to :bnb

  has_and_belongs_to_many :bookings
  has_many  :guests, through: :bookings

  validates :description, :rates, :room_number, :capacity, presence: true
  validates :room_number, :capacity, numericality: true
  validates :rates, format: { with: /^\d{1,4}(\.\d{0,2})?$/ }, numericality: true

  validates :description, length: { minimum: 2 }

  scope :unbooked_rooms, -> start_date, end_date { where('id NOT IN (select id from rooms where id in (?))', Booking.includes(:event, :rooms).where('events.start_at <= ? AND events.end_at >= ?', end_date, start_date).collect(&:rooms).flatten.map(&:id)) }

  def room_info
    "#{description} Capacity: #{capacity} Rate: #{rates}"
  end

end
