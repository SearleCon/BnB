class UserObserver < ActiveRecord::Observer
  def after_create(user)
    plan = Plan.find_by_free(true)
    subscription = plan.subscriptions.build(user_id: user)
    subscription.save!
    UserMailer.delay.welcome(user)
  end
end
