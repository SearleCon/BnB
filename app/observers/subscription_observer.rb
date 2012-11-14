class SubscriptionObserver < ActiveRecord::Observer

  def before_create(subscription)
     subscription.expiry_date = Time.now + subscription.plan.duration.months
  end

  def after_create(subscription)
    @previous_subscription = Subscription.find_last_by_user_id_and_active_profile(subscription.user_id,true)
    unless @previous_subscription.nil?
      @previous_subscription.toggle!(:active_profile)
    end
    subscription.toggle!(:active_profile)
  end
end
