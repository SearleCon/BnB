# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#  user_id                        :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  active_profile                 :boolean          default(FALSE)
#  plan_id                        :integer
#  expiry_date                    :datetime
#

class Subscription < ActiveRecord::Base
  belongs_to :plan
  attr_accessor :paypal_payment_token

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment
    response = paypal.request_payment
    response.approved? && response.success? ? save! : false
  end

  def cancel
    response = paypal.cancel
    response.success?
  end

  def reactivate
    response = paypal.reactivate
    response.success?
  end

  def has_expired?
    Time.now > self.expiry_date
  end

  def payment_provided?
    paypal_payment_token.present?
  end

end
