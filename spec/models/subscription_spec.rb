# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  email                          :string(255)
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#  user_id                        :integer
#  plan                           :string(255)
#  price                          :decimal(, )
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'spec_helper'

describe Subscription do
  pending "add some examples to (or delete) #{__FILE__}"
end
