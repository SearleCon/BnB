# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          primary key
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#  user_id                        :integer
#  created_at                     :timestamp        not null
#  updated_at                     :timestamp        not null
#  active_profile                 :boolean          default(FALSE)
#  plan_id                        :integer
#  expiry_date                    :timestamp
#

require 'spec_helper'

describe Subscription do
  pending "add some examples to (or delete) #{__FILE__}"
end
