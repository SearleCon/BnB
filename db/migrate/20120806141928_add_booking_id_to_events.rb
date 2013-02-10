class AddBookingIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :booking_id, :integer
  end
end
