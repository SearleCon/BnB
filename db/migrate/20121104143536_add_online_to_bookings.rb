class AddOnlineToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :online, :boolean, default: false

  end
end
