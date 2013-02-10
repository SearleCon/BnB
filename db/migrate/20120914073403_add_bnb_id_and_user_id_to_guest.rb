class AddBnbIdAndUserIdToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :bnb_id, :integer
    add_column :guests, :user_id, :integer
  end
end
