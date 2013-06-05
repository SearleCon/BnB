# == Schema Information
#
# Table name: bookings
#
#  id         :integer          primary key
#  guest_id   :integer
#  active     :boolean          default(TRUE)
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  status     :string(255)      default("provisional")
#  bnb_id     :integer
#  user_id    :integer
#  online     :boolean          default(FALSE)
#

class Booking < ActiveRecord::Base
  belongs_to :bnb
  belongs_to :guest
  has_many :line_items, dependent: :delete_all
  has_and_belongs_to_many :rooms
  has_one :event, dependent: :delete
  belongs_to :rate

  attr_accessible :active, :guest_attributes, :rooms, :status, :online, :event_attributes, :bnb_id, :guest_id, :room_ids, :rate_id

  accepts_nested_attributes_for :event
  accepts_nested_attributes_for :guest, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :guest
  validates_presence_of :rooms
  validates_presence_of :rate

  before_save :set_event_details

  default_scope -> {where(active: true)}
  scope :inactive, -> { where(active: false) }

  delegate :name, :start_at, :end_at, :color, :duration, to: :event, prefix: true

  enum :status, [:provisional, :booked, :checked_in, :closed]

  EVENT_COLORS = {
      booked: 'blue',
      checked_in: 'green',
      closed: 'orange',
      provisional: 'red'
  }


  def check_out
    line_items.clear
    line_items.build(description: rate.description, value: (rate.price * event_duration) )
    save
  end

  def total_price
   line_items.sum(:value)
  end

  private
  def set_event_details
     event[:name] = "#{guest[:name]} (#{guest[:contact_number]} #{guest[:email]})"
     event[:color] = EVENT_COLORS.fetch(self[:status].to_sym)
  end
end
