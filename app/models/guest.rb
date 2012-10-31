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
#

class Guest < ActiveRecord::Base
  belongs_to :bnb
  has_many :bookings
  has_many :rooms, :through => :bookings

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :surname, :contact_number, presence: true
  validates :contact_number, numericality: true
  validates :contact_number, length: { is: 10 }
  validates :email, format: { with: VALID_EMAIL_REGEX},  uniqueness: { case_sensitive: false }, allow_nil: true

  scope :search_by_name, lambda { |term|
    order(:name).where("name like ?", "%#{term}%")
  }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
