# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  guest_id   :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)      default("provisional")
#  bnb_id     :integer
#

class Booking < ActiveRecord::Base
  belongs_to :bnb
  belongs_to :guest
  has_many :line_items
  has_and_belongs_to_many :rooms
  has_one :event, :dependent => :delete

  delegate :name, :start_at, :end_at, :to => :event, :prefix => true
  validates :guest_name, presence: true


  accepts_nested_attributes_for :event
  accepts_nested_attributes_for :guest, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :line_items

  scope :needs_check_in, lambda { |specified_date|
     joins(:event).where("date(events.start_at) =?", specified_date).where(status: :booked)
  }

  scope :needs_check_out, lambda { |specified_date|
    joins(:event).where("date(events.end_at) =?", specified_date).where(status: :checked_in)
  }

  scope :active_bookings_by_bnb, lambda { |bnb|
        where("status != ? and bnb_id = ?",:closed, bnb)
  }

  enum :status, [:provisional, :booked, :checked_in, :closed]

  EVENT_COLORS = { :provisional =>  'blue', :booked => 'green', :checked_in => 'red', :closed => 'orange' }

  def status_changed(old, new)
    case new
      when :booked
         self.event.color = EVENT_COLORS[:booked]
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

  def total_price
    total = 0
    line_items.each do |item|
      total = total + item.value
    end
    total
  end

  def self.search(search)
    if search
      joins(:bnb).where("bnbs.name like ?", "%#{search}%")
    else
      scoped
    end

  end

end
