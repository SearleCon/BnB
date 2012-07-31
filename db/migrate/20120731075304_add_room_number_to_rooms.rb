class AddRoomNumberToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :room_number, :integer
  end
end
