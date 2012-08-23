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
#

class Bnb < ActiveRecord::Base
  has_many :photos, :dependent => :delete_all
  has_many :rooms, :dependent => :delete_all

  attr_accessor :status
  attr_accessor :number_of_rooms


  after_initialize(:on => :create) do
    self.status = 'inactive'
  end


  validates :name, :description, :presence => true, :if => :active_or_bnb_details?
  validates :email, :address_line_one, :address_line_two, :city, :postal_code, :telephone_number, :website, :presence => true, :if => :active_or_contact_details?
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

end
