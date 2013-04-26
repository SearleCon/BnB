class AddRateIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :rate_id, :integer
  end
end
