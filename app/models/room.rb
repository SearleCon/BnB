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
  belongs_to :bnb

  has_and_belongs_to_many :bookings
  has_many  :guests, :through => :bookings

  validates :description, :rates, :room_number, :capacity, presence: true
  validates :rates, :room_number, :capacity, numericality: true
  validates :description, length: { minimum: 2 }

  scope :booked, lambda { |start_date, end_date|
     includes({ :bookings => :event}).where('(events.start_at BETWEEN ? AND ? OR events.end_at BETWEEN ? AND ? OR events.start_at <= ? AND events.end_at >= ?) And status != ?',start_date, end_date, start_date, end_date, start_date, end_date, :closed)
  }

  scope :has_en_suite, where(:en_suite => true)

  def self.search(search)
    if search
      where('description LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
