class Room < ActiveRecord::Base
  belongs_to :bnb

  scope :has_en_suite, where(:en_suite => true)

end
