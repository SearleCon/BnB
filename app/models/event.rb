# == Schema Information
#
# Table name: events
#
#  id         :integer          primary key
#  name       :string(255)
#  start_at   :timestamp
#  end_at     :timestamp
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  booking_id :integer
#  color      :string(255)      default("blue")
#

class Event < ActiveRecord::Base
  belongs_to :booking
  after_initialize :set_default_date, :if => :new_record?

  attr_accessible :name, :start_at, :end_at, :color

  scope :by_bookings, -> bookings { includes(:booking => :bnb).where(:booking_id => bookings) }

  def as_json(options = {})
    {
        :id => self.id,
        :title => self.name,
        :description =>  "",
        :start => start_at,
        :end => end_at,
        :allDay => true,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.bnb_booking_path(self.booking.bnb, booking_id),
        :edit_booking_url => Rails.application.routes.url_helpers.edit_bnb_booking_path(self.booking.bnb, booking_id),
        :color => self.color
    }
  end

  def start_at
    self[:start_at].strftime('%A, %d %B %Y')
  end

  def end_at
    self[:end_at].strftime('%A, %d %B %Y')
  end

  private

  def set_default_date
      write_attribute(:start_at, Date.today) if self[:start_at].nil?
      write_attribute(:end_at, read_attribute(:start_at) + 1.day) unless self[:end_at].present?
  end

end
