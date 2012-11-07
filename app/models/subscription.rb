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

class Subscription < ActiveRecord::Base
  attr_accessor :paypal_payment_token

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment
    response = paypal.make_recurring
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end

end
