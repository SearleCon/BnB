# == Schema Information
#
# Table name: bnbs
#
#  id               :integer          primary key
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
#  created_at       :timestamp        not null
#  updated_at       :timestamp        not null
#  user_id          :integer
#  latitude         :float
#  longitude        :float
#  rating           :integer
#  region           :string(255)
#  standard_rate    :decimal(, )
#

class Bnb < ActiveRecord::Base

  include DelegateAssociation

  has_many :guests, :dependent => :delete_all
  has_many :photos, :dependent => :delete_all
  has_many :rooms, :dependent => :delete_all
  has_many :bookings, :dependent => :delete_all

  attr_accessible :name, :description, :email, :address_line_one, :address_line_two, :city, :postal_code, :country, :telephone_number, :website, :contact_person, :twitter_account, :standard_rate, :region, :rating, :facebook_page


  attr_accessor :status
  attr_accessor :number_of_rooms

  scope :find_by_location, -> search { where('city like ? or region = ? or country = ?' , "%#{search.city}%", search.region, search.country) }

  geocoded_by :full_address

  acts_as_gmappable :process_geocoding => false

  after_initialize :set_default_status
  after_commit :fetch_address, :if => :persisted?

  validates :name, :description, :standard_rate, :presence => true, :if => :active_or_bnb_details?
  validates :email, :address_line_one, :address_line_two, :region, :city, :postal_code, :telephone_number, :website, :presence => true, :if => :active_or_contact_details?
  validates :facebook_page, :twitter_account, :contact_person, :presence => true, :if => :active_or_social_media?


  def full_address
     [address_line_one, address_line_two, city, postal_code, country].reject(&:nil?).join(",")
  end

  def co_ordinates
    [latitude, longitude].reject(&:nil?).join(",")
  end

  def gmaps4rails_address
    full_address
  end

  private
  def set_default_status
    if new_record?
      self.status = 'inactive'
    else
      self.status = 'active'
    end
  end

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

  def address_changed?
    ['address_line_one', 'address_line_two', 'city', 'postal_code', 'country'].any? { |k| self.previous_changes.key?(k) }
  end

  def fetch_address
    Delayed::Job.enqueue ProcessAddressJob.new(self.id) if address_changed?
  end

end
