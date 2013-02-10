class AddBnbIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :bnb_id, :integer
  end
end

