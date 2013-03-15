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
#  user_id    :integer
#  online     :boolean          default(FALSE)
#

class Booking < ActiveRecord::Base
  belongs_to :bnb
  belongs_to :guest
  has_many :line_items, :dependent => :delete_all
  has_and_belongs_to_many :rooms
  has_one :event, :dependent => :delete

  default_scope -> {where(:active => true)}

  scope :inactive, -> { where(:active => false) }

  before_create :set_event_name
  before_save :set_event_color
  after_commit :send_notifications, :if => :notification_required?
  after_commit :send_booking_confirmation, :if => :confirmation_required?


  delegate :name, :start_at, :end_at, :to => :event, :prefix => true
  validates_presence_of :guest
  validates_associated :guest
  validates_presence_of :rooms

  accepts_nested_attributes_for :event
  accepts_nested_attributes_for :guest, :reject_if => :all_blank, :allow_destroy => true

  enum :status, [:provisional, :booked, :checked_in, :closed]

  EVENT_COLORS = {
      :booked => 'blue',
      :checked_in => 'green',
      :closed => 'orange',
      :provisional => 'red'
  }

  def total_price
   self.line_items.sum(:value)
  end

  def self.search(search)
    if search
      joins(:bnb).where("lower(bnbs.name) like ?", "%#{search.downcase}%")
    else
      scoped
    end
  end

  private
  def confirmation_required?
     updated? && booked? && online?
  end

  def notification_required?
    created? && online?
  end


  def send_notifications
    UserMailer.delay.booking_made(self)
    UserMailer.delay.notify_bnb(self)
  end

  def send_booking_confirmation
    UserMailer.delay.confirmation_received(self)
  end

  def set_event_name
    self.event.name = "#{self.guest.name} (#{self.guest.contact_number} #{self.guest.email})"
  end

  def set_event_color
    self.event.color = EVENT_COLORS[self.status]
  end
end
