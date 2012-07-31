class AddBnbIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :bnb_id, :integer
  end
end
