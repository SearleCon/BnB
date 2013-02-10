class PaypalIpnObserver < ActiveRecord::Observer
  observe :payment_notification

  def after_create(payment_notification)
    notification = PayPal::Recurring::Notification.new(payment_notification.params)
    @subscription = Subscription.find_by_paypal_customer_token(notification.params[:payer_id])

    if notification.recurring_payment_profile?
      BillingMailer.delay.subscription_activated(@subscription)
    elsif (notification.recurring_payment? || notification.express_checkout?) && notification.completed?
      BillingMailer.delay.payment_received(@subscription)
    else
      BillingMailer.delay.paypal_error(@subscription, payment_notification)
      @subscription.toggle!(:active_profile)
    end
  end
end

