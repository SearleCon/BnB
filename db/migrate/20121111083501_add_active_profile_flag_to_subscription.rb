class AddActiveProfileFlagToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :active_profile, :boolean, :default => false

  end
end
