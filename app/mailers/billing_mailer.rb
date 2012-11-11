class BillingMailer < ActionMailer::Base
  default from: "Billing@SearleConsulting.co.za"

  def subscription_activated(subscription)
    @user = User.find(subscription.user_id)
    @subscription = subscription
    mail to: @user.email, subject: "Subscription activated"
  end

  def payment_received(subscription)
    @user = User.find(subscription.user_id)
    @subscription = subscription
    mail to: @user.email, subject: "Thank you for your payment"
  end

  def paypal_error(subscription,notification)
    @user = User.find(subscription.user_id)
    @subscription = subscription
    @notification = notification
    mail to: 'support@searleconsulting.co.za', subject: "Paypal error: Notification #{notification.id}"
  end

end
