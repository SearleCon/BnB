# == Schema Information
#
# Table name: events
#
#  id         :integer          primary key
#  name       :string(255)
#  start_at   :timestamp
#  end_at     :timestamp
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  booking_id :integer
#  color      :string(255)      default("blue")
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
