class AddAvailableAndCapacityToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :available, :boolean, default: false
    add_column :rooms, :capacity, :integer, default: 1
  end
end
