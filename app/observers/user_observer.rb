class UserObserver < ActiveRecord::Observer

  def after_create(user)
    add_subscription(user) if user.is_owner?
  end

  def after_commit(user)
    UserMailer.delay.welcome(user) if user.persisted? && user.created_at == user.updated_at
  end

  private
  def add_subscription(user)
    plan = Plan.find_by_free(true)
    subscription = plan.subscriptions.build(user_id: user.id)
    subscription.save!
  end
end
