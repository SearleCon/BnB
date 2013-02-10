class ChangeRoomAvailableDefaultTrue < ActiveRecord::Migration
  def up
    change_column :rooms, :available, :boolean, default: true
  end

  def down
  end
end
