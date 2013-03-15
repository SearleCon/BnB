# == Schema Information
#
# Table name: guests
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  surname        :string(255)
#  contact_number :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  bnb_id         :integer
#  user_id        :integer
#  email          :string(255)
#

class Guest < ActiveRecord::Base
  belongs_to :bnb
  has_many :bookings, :dependent => :destroy
  has_many :rooms, :through => :bookings

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :surname, :contact_number, presence: true
  validates :contact_number, numericality: true
  validates :contact_number, length: { is: 10 }
  validates :email, format: { with: VALID_EMAIL_REGEX}, allow_nil: true

  scope :search, -> term { where('lower(name) LIKE ?', "%#{term}%") }


  def full_name
    "#{self.name} #{self.surname}".titleize
  end

end
