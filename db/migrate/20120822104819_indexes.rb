class Indexes < ActiveRecord::Migration
  def up
    add_index :bnbs, :user_id
    add_index :bookings, :guest_id
    add_index :bookings_rooms, :booking_id
    add_index :bookings_rooms, :room_id
    add_index :events, :booking_id
    add_index :photos, :bnb_id
    add_index :rooms, :bnb_id
  end

  def down
    remove_index :bnbs, :user_id
    remove_index :bookings, :guest_id
    remove_index :bookings_rooms, :booking_id
    remove_index :bookings_rooms, :room_id
    remove_index :events, :booking_id
    remove_index :photos, :bnb_id
    remove_index :rooms, :bnb_id
  end
end
