class Rate < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :rate_type, foreign_key: :rate_type_id

  attr_accessible :active, :description , :price

  validates :description, presence: true
  validates :price, format: { with: /^\d{1,4}(\.\d{0,2})?$/ }, numericality: true

  after_initialize :set_default_values, if: :new_record?

  def rate_info
    "#{self[:description]} #{helpers.number_to_currency(self[:price], precision: 2)}"
  end

  private
  def set_default_values
    self[:active] = true
    self[:per_person] = false
    self[:per_room] = false
  end

  def helpers
    ActionController::Base.helpers
  end
end
