# == Schema Information
#
# Table name: rate_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RateType < ActiveRecord::Base
  attr_accessible :name
end
