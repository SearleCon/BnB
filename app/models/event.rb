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
  belongs_to :booking, touch: true

  attr_accessible :name, :start_at, :end_at, :color

  after_initialize :default_values, if: :new_record?

  scope :by_bookings, -> bookings { includes(booking: :bnb).where(booking_id: bookings) }

  def as_json(options = {})
    {
        id: self[:id],
        title: self[:name],
        description: "",
        start: self[:start_at],
        end: self[:end_at],
        allDay: true,
        recurring: false,
        url: Rails.application.routes.url_helpers.booking_path(booking),
        edit_booking_url: Rails.application.routes.url_helpers.edit_booking_path(booking),
        color: self[:color]
    }
  end

  def start_at
   self[:start_at].strftime('%A, %d %B %Y')
  end

  def end_at
    self[:end_at].strftime('%A, %d %B %Y')
  end

  def duration
    (self[:end_at].to_date - self[:start_at].to_date).to_i
  end

  private

  def default_values
      self[:start_at] = Time.zone.now unless self[:start_at]
      self[:end_at] = self[:start_at].advance(days: 1) unless self[:end_at]
  end
end
