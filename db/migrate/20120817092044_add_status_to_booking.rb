class AddStatusToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :status, :string, :default => 'provisional'
    Booking.find_each do |booking|
      booking.status =  'provisional'
      booking.save
    end
  end
end
