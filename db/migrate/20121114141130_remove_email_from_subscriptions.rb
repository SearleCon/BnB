class RemoveEmailFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :email
      end

  def down
    add_column :subscriptions, :email, :string
  end
end
