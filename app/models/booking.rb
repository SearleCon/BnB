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
#

class Booking < ActiveRecord::Base
  belongs_to :bnb
  belongs_to :guest
  has_many :line_items
  has_and_belongs_to_many :rooms
  has_one :event, :dependent => :delete

  attr_accessor :rooms_required

  delegate :name, :start_at, :end_at, :to => :event, :prefix => true
  validates_presence_of :guest
  validates_associated :guest
  validates_presence_of :rooms, :if => :must_have_rooms?

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

  scope :active_bookings_by_user, lambda { |user|
        includes(:event, :bnb).where("status != ? AND bookings.user_id =? ", :closed, user.id)
  }

  scope :inactive_bookings_by_user, lambda { |user|
    includes(:event, :bnb).where("status = ? AND bookings.user_id = ? ", :closed, user.id)
  }

  enum :status, [:provisional, :booked, :checked_in, :closed]

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

  private
  def must_have_rooms?
    self.rooms_required
  end
end
