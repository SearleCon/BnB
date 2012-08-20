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

  scope :in_range, lambda { |start_date, end_date|
    {:conditions => [
        '(start_at BETWEEN ? AND ? OR end_at BETWEEN ? AND ?) OR (start_at <= ? AND end_at >= ?)',
        start_date, end_date, start_date, end_date, start_date, end_date
    ]}
  }


  scope :has_en_suite, where(:en_suite => true)

  def self.open_days (start_date,end_date)
   all(:include => { :bookings => :event}, :conditions => ['(events.start_at BETWEEN ? AND ? OR events.end_at BETWEEN ? AND ?) OR (events.start_at <= ? AND events.end_at >= ?)', start_date, end_date, start_date, end_date, start_date, end_date])
  end






end
