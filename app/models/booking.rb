# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  guest_id   :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Booking < ActiveRecord::Base
  belongs_to :guest
  has_and_belongs_to_many :rooms
  has_one :event, :dependent => :delete

  delegate :name, :start_at, :end_at, :to => :event, :prefix => true

  accepts_nested_attributes_for :event
  accepts_nested_attributes_for :guest, :reject_if => :all_blank, :allow_destroy => true

  scope :needs_check_in, lambda { |specified_date|
     joins(:event).where("date(events.start_at) =?", specified_date).where(status: :booked)
  }

  scope :needs_check_out, lambda { |specified_date|
    joins(:event).where("date(events.end_at) =?", specified_date).where(status: :checked_in)
  }



  enum :status, [:provisional, :booked, :checked_in, :closed]

  EVENT_COLORS = { :provisional =>  'blue', :booked => 'green', :checked_in => 'red', :closed => 'orange' }

  def status_changed(old, new)
    case new
      when :booked
      when :checked_in
        self.event.color = EVENT_COLORS[:checked_in]
      when :closed
        self.event.color = EVENT_COLORS[:closed]
    end
  end

  def guest_name
    guest.try(:name)
  end

  def guest_name=(name)
    self.guest = Guest.find_by_name(name) if name.present?
  end

end
