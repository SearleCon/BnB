# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  booking_id :integer
#  color      :string(255)      default("blue")
#

class Event < ActiveRecord::Base
  belongs_to :booking
  after_initialize :set_default_date, :if => :new_record?

  scope :by_bnb,lambda { |bnb| where(:booking_id => bnb.bookings) }

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
