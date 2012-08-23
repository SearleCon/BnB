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
#

class Event < ActiveRecord::Base
  belongs_to :booking




  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
        :id => self.id,
        :title => self.name,
        :description =>  "",
        :start => start_at,
        :end => end_at,
        :allDay => true,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.booking_path(booking_id),
        :color => self.color
    }

  end




end
