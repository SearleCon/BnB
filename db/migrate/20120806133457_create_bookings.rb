class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :guest_id
      t.integer :room_id
      t.boolean :active

      t.timestamps
    end
  end
end
