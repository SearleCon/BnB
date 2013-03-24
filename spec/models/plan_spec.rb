# == Schema Information
#
# Table name: plans
#
#  id         :integer          primary key
#  duration   :integer
#  price      :decimal(, )
#  active     :boolean
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  name       :string(255)
#  free       :boolean
#

require 'spec_helper'

describe Plan do
  pending "add some examples to (or delete) #{__FILE__}"
end
