class RemoveRoomIdFromBooking < ActiveRecord::Migration
  def up
    remove_column :bookings, :room_id
  end

  def down
    add_column :bookings, :room_id, :integer
  end
end
