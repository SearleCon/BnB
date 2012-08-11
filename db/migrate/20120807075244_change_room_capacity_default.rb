class ChangeRoomCapacityDefault < ActiveRecord::Migration
  def up
    change_column :rooms, :capacity, :integer, default: 2
  end

  def down
  end
end
