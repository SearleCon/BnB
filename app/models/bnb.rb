class Bnb < ActiveRecord::Base
  has_many :photos

  attr_accessor :status

  before_validation(:on => :create) do
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
