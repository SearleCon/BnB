# == Schema Information
#
# Table name: rates
#
#  id            :integer          not null, primary key
#  price         :decimal(, )
#  active        :boolean
#  description   :string(255)
#  rateable_id   :integer
#  rateable_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rate < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true

  attr_accessible :active, :description , :price

  validates :description, presence: true
  validates :price, format: { with: /^\d{1,4}(\.\d{0,2})?$/ }, numericality: true

  after_initialize :default_values

  def rate_info
    "#{self[:description]} #{helpers.number_to_currency(self[:price], precision: 2)}"
  end

  private
  def default_values
    self[:active] = true if new_record?
  end

  def helpers
    ActionController::Base.helpers
  end
end
