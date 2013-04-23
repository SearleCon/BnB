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
#  slug             :string(255)
#  approved         :boolean          default(FALSE)
#

class Bnb < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :approved, -> { where(approved: true) }


  has_many :guests, dependent: :delete_all
  has_many :photos, dependent: :delete_all
  has_many :rooms, dependent: :delete_all
  has_many :bookings, dependent: :delete_all
  has_many :rates, as: :rateable


  accepts_nested_attributes_for :rates, reject_if: :all_blank, allow_destroy: true


  attr_accessible :name, :description, :email, :address_line_one, :address_line_two, :city, :postal_code, :country, :telephone_number, :website, :contact_person, :twitter_account, :standard_rate, :region, :rating, :facebook_page, :number_of_rooms, :user_id, :approved, :rates_attributes
  attr_accessor :status


  geocoded_by :full_address

  acts_as_gmappable lat: 'latitude', lng: 'longitude', process_geocoding: false, check_process: false,
                    address: :full_address,
                    msg: "is not valid according to Google Maps"


  before_validation :normalize_blank_values
  after_commit :fetch_address, if: :persisted?

  validates :name, :description, :standard_rate, presence: true, if: :active_or_bnb_details?

  validates :standard_rate, format: { with: /^\d{1,4}(\.\d{0,2})?$/ }, numericality: true, if: :active_or_bnb_details?
  validates  :contact_person, :email, :address_line_one, :address_line_two, :city, :postal_code, :telephone_number, presence: true, if: :active_or_contact_details?

  def geocode?
    active_or_contact_details? || address_changed?
  end

  def full_address
    [self[:address_line_one], self[:address_line_two], self[:city], self[:postal_code], self[:country]].reject(&:nil?).join(",")
  end

  def co_ordinates
    [latitude, longitude].reject(&:nil?).join(",")
  end

  def gmaps4rails_address
    full_address
  end



  def website
    self[:website] || 'N/A'
  end

  def status
    @status ||= new_record? ? 'inactive' : 'active'
  end

  private
  def active?
    self[:status] == 'active'
  end

  def active_or_bnb_details?
    status.include?('bnb_details') || active?
  end

  def active_or_contact_details?
    status.include?('contact_details') || active?
  end

  def active_or_social_media?
    status.include?('social_media') || active?
  end

  def address_changed?
    ['address_line_one', 'address_line_two', 'city', 'postal_code', 'country'].any? { |k| self.previous_changes.key?(k) }
  end

  def fetch_address
    Delayed::Job.enqueue ProcessAddressJob.new(self[:id]) if address_changed?
  end

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].strip! if self[column].respond_to?(:strip!)
      self[column] = nil unless self[column].present?
    end
  end




end
