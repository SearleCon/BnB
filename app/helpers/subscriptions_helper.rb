module SubscriptionsHelper
  def number_of_days_left
    (current_user.active_subscription.expiry_date.to_date - Date.today).to_i
  end
end
