# == Schema Information
#
# Table name: bnbs
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  email            :string(255)
#  address_line_one :string(255)
#  address_line_two :string(255)
#  city             :string(255)
#  postal_code      :string(255)
#  country          :string(255)
#  telephone_number :string(255)
#  website          :string(255)
#  contact_person   :string(255)
#  twitter_account  :string(255)
#  facebook_page    :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  latitude         :float
#  longitude        :float
#  rating           :integer
#  region           :string(255)
#  standard_rate    :decimal(, )
#

class Bnb < ActiveRecord::Base
  has_many :guests, :dependent => :delete_all
  has_many :photos, :dependent => :delete_all
  has_many :rooms, :dependent => :delete_all
  has_many :bookings, :dependent => :delete_all

  attr_accessor :status
  attr_accessor :number_of_rooms
  attr_accessor :address_processed

  acts_as_gmappable :process_geocoding => false

  after_initialize :set_default_status
  after_save :fetch_address, :if => :address_details_changed?


  validates :name, :description, :standard_rate, :presence => true, :if => :active_or_bnb_details?
  validates :email, :address_line_one, :address_line_two, :region, :city, :postal_code, :telephone_number, :website, :presence => true, :if => :active_or_contact_details?
  validates :facebook_page, :twitter_account, :contact_person, :presence => true, :if => :active_or_social_media?

  def active?
    self.status == 'active'
  end

  def active_or_bnb_details?
    self.status.include?('bnb_details') || active?
  end

  def active_or_contact_details?
    self.status.include?('contact_details') || active?
  end

  def active_or_social_media?
    self.status.include?('social_media') || active?
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.find_by_location(search)
    where('city like ? or region = ? or country = ?' , "%#{search.city}%", search.region, search.country)
  end

  def address_details_changed?
     address_line_one_changed? || address_line_two_changed? || city_changed? || postal_code_changed? || country_changed?
  end

  def full_address
     "#{address_line_one}, #{address_line_two}, #{city}, #{postal_code}, #{country}"
  end

  def gmaps4rails_address
    full_address
  end

  def address_processed?
    self.address_processed == "y"
  end

  private
  def set_default_status
    if new_record?
      self.status = 'inactive'
    else
      self.status = 'active'
    end
  end

  def fetch_address
    unless self.address_processed?
     Delayed::Job.enqueue ProcessAddressJob.new(self.id)
    end
  end
end
