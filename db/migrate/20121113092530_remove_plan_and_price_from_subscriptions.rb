class RemovePlanAndPriceFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :plan
    remove_column :subscriptions, :price
  end

  def down
    add_column :subscriptions, :price, :decimal
    add_column :subscriptions, :plan, :string
  end
end
