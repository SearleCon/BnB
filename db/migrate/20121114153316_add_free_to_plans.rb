class AddFreeToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :free, :boolean

  end
end
