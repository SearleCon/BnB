# == Schema Information
#
# Table name: payment_notifications
#
#  id             :integer          not null, primary key
#  params         :text
#  user_id        :integer
#  status         :string(255)
#  transaction_id :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PaymentNotification < ActiveRecord::Base
  serialize :params

  after_create :send_notifications

  def send_notifications
    notification = PayPal::Recurring::Notification.new(self.params)
    @subscription = Subscription.find_by_paypal_customer_token(notification.params[:payer_id])

    if notification.recurring_payment_profile?
      BillingMailer.delay.subscription_activated(@subscription)
    elsif (notification.recurring_payment? || notification.express_checkout?) && notification.completed?
      BillingMailer.delay.payment_received(@subscription)
    else
      BillingMailer.delay.paypal_error(@subscription, self)
      @subscription.toggle!(:active_profile)
    end
  end

end
