# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  duration   :integer
#  price      :decimal(, )
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  free       :boolean
#

require 'spec_helper'

describe Plan do
  pending "add some examples to (or delete) #{__FILE__}"
end
