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
  has_many :line_items
  has_and_belongs_to_many :rooms
  has_one :event, :dependent => :delete


  delegate :name, :start_at, :end_at, :to => :event, :prefix => true
  validates_presence_of :guest
  validates_associated :guest
  validates_presence_of :rooms

  accepts_nested_attributes_for :event
  accepts_nested_attributes_for :guest, :reject_if => :all_blank, :allow_destroy => true


  scope :active_bookings, where("status != ?", :closed)


  enum :status, [:provisional, :booked, :checked_in, :closed]

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

end
