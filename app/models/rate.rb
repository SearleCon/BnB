class Rate < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :rate_type, foreign_key: :rate_type_id

  attr_accessible :active, :name, :per_person, :per_room, :price, :rate_type_id

  after_initialize :set_default_values, if: :new_record?



  private
  def set_default_values
    self[:active] = true
    self[:per_person] = false
    self[:per_room] = false
  end

end
