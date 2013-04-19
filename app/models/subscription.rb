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

class Subscription < ActiveRecord::Base
  belongs_to :plan
  attr_accessor :paypal_payment_token

  attr_accessible :paypal_customer_token, :paypal_recurring_profile_token, :active_profile, :expiry_date, :user_id

  default_scope -> {where(active_profile: true) }
  after_initialize :set_expiry_date
  before_create :deactivate_previous_subscription


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

  private
  def set_expiry_date
    self.expiry_date = Time.now + self.plan.duration.months if self.new_record?
  end

  def deactivate_previous_subscription
    previous = Subscription.where(user_id: self.user_id).first
    previous.try(:toggle!,:active_profile)
  end

end
