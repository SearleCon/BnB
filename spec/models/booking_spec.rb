# == Schema Information
#
# Table name: bookings
#
#  id         :integer          primary key
#  guest_id   :integer
#  active     :boolean          default(TRUE)
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  status     :string(255)      default("provisional")
#  bnb_id     :integer
#  user_id    :integer
#  online     :boolean          default(FALSE)
#

require 'spec_helper'

describe Booking do
  pending "add some examples to (or delete) #{__FILE__}"
end
