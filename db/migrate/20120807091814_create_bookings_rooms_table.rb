class CreateBookingsRoomsTable < ActiveRecord::Migration
  def up
    create_table :bookings_rooms, :id => false do |t|
      t.integer :booking_id
      t.integer :room_id
    end
  end

  def down
    drop_table :bookings_rooms
  end


end
