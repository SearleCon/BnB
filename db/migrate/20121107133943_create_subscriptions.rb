class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.string :paypal_customer_token
      t.string :paypal_recurring_profile_token
      t.integer :user_id
      t.string :plan
      t.decimal :price


      t.timestamps
    end
  end
end
