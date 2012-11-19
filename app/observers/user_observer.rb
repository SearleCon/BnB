class UserObserver < ActiveRecord::Observer
  def after_create(user)
    add_subscription(user) if user.is_owner?
    UserMailer.delay.welcome(user)
  end

  private
  def add_subscription(user)
    plan = Plan.find_by_free(true)
    subscription = plan.subscriptions.build(user_id: user.id)
    subscription.save!
  end
end
