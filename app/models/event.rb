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
        :update_url => Rails.application.routes.url_helpers.booking_event_path(self.booking, self.id),
        :color => self.color
    }
  end

  def formatted_start_at(start_at)
    write_attribute(:start_at, start_at.strftime('%A, %d %B %Y'))
  end

  def formatted_end_at(end_at)
    write_attribute(:end_at, end_at.strftime('%A, %d %B %Y'))
  end

end
