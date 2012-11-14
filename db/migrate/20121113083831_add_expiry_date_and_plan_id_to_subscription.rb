class AddExpiryDateAndPlanIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :plan_id, :integer

    add_index :subscriptions, :plan_id

    add_column :subscriptions, :expiry_date, :datetime

  end
end
